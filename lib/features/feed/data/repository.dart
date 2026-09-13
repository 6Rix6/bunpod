import 'dart:async';

import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:bunpod/bunpod.dart';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pool/pool.dart';

abstract interface class PodcastFeedRepository {
  AppTaskEither<PodcastFeed> fetchFeed(String url);
  Future<AppEither<List<PodcastFeed>>> fetchFeeds(List<String> urls);
  FutureOr<void> close();
}

class PodcastFeedRepositoryImpl implements PodcastFeedRepository {
  PodcastFeedRepositoryImpl(
    this._datasource, {
    required FeedDao feedDao,
    required HostDao hostDao,
    required CategoryDao categoryDao,
  }) : _feedDao = feedDao,
       _hostDao = hostDao,
       _categoryDao = categoryDao;

  final RSSPodcastDataSource _datasource;
  final FeedDao _feedDao;
  final HostDao _hostDao;
  final CategoryDao _categoryDao;

  // TODO: customizable resource count
  final Pool _pool = Pool(4);

  @override
  AppTaskEither<PodcastFeed> fetchFeed(String url) {
    return TaskEither<AppError, FeedRow?>.tryCatch(
      () => _feedDao.getByUrl(url),
      (error, _) => CacheError(error.toString()),
    ).flatMap((cached) => _fetchAndBuild(url, cached));
  }

  AppTaskEither<PodcastFeed> _fetchAndBuild(String url, FeedRow? cached) {
    return _datasource
        .getFeed(
          url,
          etag: cached?.etag,
          lastModified: cached?.lastModified,
          contentHash: cached?.contentHash,
        )
        .flatMap(
          (result) => switch (result) {
            FeedNotModified() => _fromCache(url, cached),
            FeedModified m => _persistAndBuild(url, m),
          },
        );
  }

  AppTaskEither<PodcastFeed> _fromCache(String url, FeedRow? cached) {
    if (cached == null) {
      return TaskEither.left(
        CacheError('Got not-modified but no cache for $url'),
      );
    }

    return TaskEither.tryCatch(() async {
      final host = await _hostDao.getById(cached.hostId);
      final epRows = await _feedDao.getEpisodesForFeed(cached.id);
      final categoryRows = await _categoryDao.getCategoriesForFeed(cached.id);
      final seed = await ImageColorCache.of(cached.imageUrl);

      final channel = Channel(
        localId: cached.id,
        feedUrl: url,
        name: cached.title,
        host: host.name,
        color: seed,
        image: cached.imageUrl,
        description: cached.description,
        categories: categoryRows.map((c) => c.name).toList(),
      );

      final episodes = epRows
          .map(
            (row) => Episode(
              localId: row.id,
              guid: row.guid,
              bucket: calculateBucket(row.pubDate),
              channel: channel.name,
              host: channel.host,
              title: row.title,
              date: row.pubDate.toIso8601String(),
              color: seed,
              image: channel.image,
              feedurl: channel.feedUrl,
              audioUrl: row.audioUrl,
              total: Duration(seconds: row.totalSeconds),
            ),
          )
          .toList();

      return PodcastFeed(url: url, channel: channel, episodes: episodes);
    }, (error, _) => CacheError(error.toString()));
  }

  AppTaskEither<PodcastFeed> _persistAndBuild(String url, FeedModified m) {
    return TaskEither.tryCatch(
      () async {
        final feed = m.feed;

        if (!_isValidFeed(feed)) {
          throw _ValidationException('Invalid rss feed: $url');
        }

        final hostId = await _hostDao.upsertHost(
          HostsCompanion.insert(name: feed.ownerName!),
        );

        final feedId = await _feedDao.upsertFeed(
          FeedsCompanion.insert(
            url: url,
            etag: Value(m.etag),
            lastModified: Value(m.lastModified),
            contentHash: Value(m.contentHash),
            title: feed.title!,
            hostId: hostId,
            imageUrl: feed.imageUrl!,
            description: feed.description ?? '',
            fetchedAt: DateTime.now(),
          ),
        );

        await _categoryDao.attachCategoriesByNameToFeed(
          feedId,
          feed.categories,
        );

        final companions = feed.episodes
            .map((e) => _toEpisodeCompanion(feedId, e))
            .whereType<EpisodesCompanion>()
            .toList();

        final episodeIds = await _feedDao.upsertEpisodes(feedId, companions);

        final podcastFeed = await feed.toPodcastFeed(
          id: feedId,
          url: url,
          episodeIds: episodeIds,
        );

        if (podcastFeed == null) {
          throw _ValidationException('Failed to convert RSSPodcastFeed: $feed');
        }

        return podcastFeed;
      },
      (error, stackTrace) => switch (error) {
        _ValidationException e => ParseError(e.message, stackTrace),
        _ => CacheError(error.toString()),
      },
    );
  }

  bool _isValidFeed(RSSPodcastFeed feed) {
    return feed.title != null &&
        feed.ownerName != null &&
        feed.imageUrl != null;
  }

  EpisodesCompanion? _toEpisodeCompanion(int feedId, RSSFeedEpisode e) {
    if (e.guid == null ||
        e.title == null ||
        e.publishedAt == null ||
        e.audioUrl == null ||
        e.duration == null) {
      logarte.log(
        'skipped invalid episode: guid=${e.guid}, title=${e.title}',
      );
      return null;
    }

    return EpisodesCompanion.insert(
      feedId: feedId,
      guid: e.guid!,
      title: e.title!,
      pubDate: e.publishedAt!,
      audioUrl: e.audioUrl!,
      totalSeconds: e.duration!.inSeconds,
    );
  }

  @override
  Future<AppEither<List<PodcastFeed>>> fetchFeeds(List<String> urls) async {
    final futures = urls.map(
      (url) => _pool.withResource(() => fetchFeed(url).run()),
    );
    final results = await Future.wait(futures);

    final feeds = <PodcastFeed>[];
    final errors = <AppError>[];

    for (final result in results) {
      result.match(
        (e) {
          logarte.log('failed to fetch feed: $e');
          errors.add(e);
        },
        feeds.add,
      );
    }

    if (feeds.isEmpty && results.isNotEmpty) {
      return Either.left(MultipleError(errors));
    }

    return Either.right(feeds);
  }

  @override
  FutureOr<void> close() async {
    await _pool.close();
  }
}

class _ValidationException implements Exception {
  _ValidationException(this.message);
  final String message;
}
