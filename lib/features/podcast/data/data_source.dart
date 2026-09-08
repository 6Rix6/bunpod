import 'dart:isolate';
import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:bunpod/bunpod.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RSSPodcastDataSource {
  AppTaskEither<RSSPodcastFeed> getFeed(String url);
}

class RSSPodcastDataSourceImpl implements RSSPodcastDataSource {
  const RSSPodcastDataSourceImpl({
    required RSSFeedClient client,
    required FeedDao feedDao,
    required CategoryDao categoryDao,
    required HostDao hostDao,
  }) : _client = client,
       _feedDao = feedDao,
       _categoryDao = categoryDao,
       _hostDao = hostDao;

  final RSSFeedClient _client;
  final FeedDao _feedDao;
  final HostDao _hostDao;

  final CategoryDao _categoryDao;

  static BaseOptions get baseOptions => BaseOptions(
    validateStatus: (status) =>
        status != null && (status >= 200 && status < 300 || status == 304),
  );

  @override
  AppTaskEither<RSSPodcastFeed> getFeed(String url) {
    final uri = Uri.tryParse(url);

    if (uri == null) {
      return TaskEither.left(
        ParseError('Failed to parse url: $url', StackTrace.current),
      );
    }

    return TaskEither<AppError, FeedRow?>.tryCatch(
      () => _feedDao.getByUrl(url),
      (error, _) => CacheError(error.toString()),
    ).flatMap((cached) => _constructRequest(uri, cached));
  }

  AppTaskEither<RSSPodcastFeed> _constructRequest(Uri uri, FeedRow? cached) {
    return TaskEither(
          () => _client.fetchFeedRaw(
            uri,
            headers: {
              'If-None-Match': ?cached?.etag,
              'If-Modified-Since': ?cached?.lastModified,
            },
          ),
        )
        .mapLeft(_mapError)
        .flatMap((response) => _handleResponse(uri, response, cached));
  }

  AppTaskEither<RSSPodcastFeed> _handleResponse(
    Uri url,
    Response<String> response,
    FeedRow? cached,
  ) {
    if (response.statusCode == 304) {
      if (cached == null) {
        return TaskEither.left(CacheError('Got 304 but no cache for $url'));
      }
      return _mapFeedRow(cached);
    }

    final body = response.data;

    if (body == null || body.isEmpty) {
      return TaskEither.left(
        ParseError('Response body is empty', StackTrace.current),
      );
    }

    return _calcFeedHash(body).flatMap(
      (hash) => Option.fromNullable(cached)
          // Cache hit only if content hash matches the freshly computed one.
          .filter((c) => c.contentHash == hash)
          .match(
            // Miss: parse the new body and persist it.
            () => _parseFeed(url, body).flatMap(
              (feed) => _persist(url, response, hash, feed),
            ),
            // Hit: reuse cached row, skip parsing/persisting.
            (c) => _mapFeedRow(c),
          ),
    );
  }

  AppTaskEither<RSSPodcastFeed> _persist(
    Uri url,
    Response<String> response,
    String hash,
    RSSPodcastFeed feed,
  ) {
    return TaskEither.tryCatch(
      () async {
        if (!_isValidFeed(feed)) {
          throw ValidationException('Invalid rss feed: $url');
        }

        final hostId = await _hostDao.upsertHost(
          HostsCompanion.insert(name: feed.ownerName!),
        );

        final feedId = await _feedDao.upsertFeed(
          FeedsCompanion.insert(
            url: url.toString(),
            etag: Value(response.headers.value('etag')),
            lastModified: Value(response.headers.value('last-modified')),
            contentHash: Value(hash),
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

        await _feedDao.upsertEpisodes(
          feedId,
          feed.episodes
              .map(
                (e) {
                  if (!_isValidEpisode(e)) {
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
                },
              )
              .whereType<EpisodesCompanion>()
              .toList(),
        );

        return feed;
      },
      (error, stackTrace) => switch (error) {
        ValidationException e => ParseError(
          e.message,
          stackTrace,
        ),
        _ => CacheError(error.toString()),
      },
    );
  }

  bool _isValidFeed(RSSPodcastFeed feed) {
    return (feed.title != null &&
        feed.ownerName != null &&
        feed.imageUrl != null);
  }

  bool _isValidEpisode(RSSFeedEpisode ep) {
    return (ep.guid != null &&
        ep.title != null &&
        ep.publishedAt != null &&
        ep.audioUrl != null &&
        ep.duration != null);
  }

  AppTaskEither<String> _calcFeedHash(String body) {
    return TaskEither.tryCatch(
      () => Isolate.run(() => RSSFeedClient.calcFeedHash(body)),
      (error, stackTrace) => ParseError(error, stackTrace),
    );
  }

  AppTaskEither<RSSPodcastFeed> _parseFeed(
    Uri url,
    String body,
  ) {
    if (kDebugMode) {
      logarte.log('Parsing rss feed: $url');
    }
    return TaskEither.tryCatch(
      () => Isolate.run(() => RSSFeedClient.parseFeed((url, body))),
      (error, stackTrace) => ParseError(error, stackTrace),
    );
  }

  AppError _mapError(ApiFailure failure) {
    return switch (failure) {
      NetworkFailure f => NetworkError(f.message, cause: f.cause),
      CancelledFailure() => CancelledError(),
      HttpFailure f => HttpError(
        statusCode: f.statusCode,
        message: f.message,
        responseBody: f.responseBody,
      ),
      ParseFailure f => ParseError(f.message, f.stackTrace),
      UnknownFailure f => UnknownError(f.error, f.stackTrace),
    };
  }

  AppTaskEither<RSSPodcastFeed> _mapFeedRow(FeedRow row) {
    return TaskEither.tryCatch(() async {
      final host = await _hostDao.getById(row.hostId);

      final epRows = await _feedDao.getEpisodesForFeed(row.id);
      final episodes = epRows.map(_mapEpisodeRow).toList();

      final categoryRows = await _categoryDao.getCategoriesForFeed(row.id);
      final categories = categoryRows.map((c) => c.name).toList();

      return RSSPodcastFeed(
        url: Uri.tryParse(row.url),
        title: row.title,
        ownerName: host.name,
        imageUrl: row.imageUrl,
        description: row.description,
        episodes: episodes,
        categories: categories,
      );
    }, (error, _) => CacheError(error.toString()));
  }

  RSSFeedEpisode _mapEpisodeRow(EpisodeRow row) {
    return RSSFeedEpisode(
      guid: row.guid,
      title: row.title,
      publishedAt: row.pubDate,
      audioUrl: row.audioUrl,
      duration: Duration(seconds: row.totalSeconds),
      imageUrl: row.imageUrl,
    );
  }
}

class ValidationException implements Exception {
  ValidationException(this.message);
  final String message;
}
