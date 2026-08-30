import 'dart:isolate';
import 'dart:async';

import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:bunpod/bunpod.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RSSPodcastDataSource {
  Future<AppEither<RSSPodcastFeed>> getFeed(String url);
  FutureOr<void> close();
}

class RSSPodcastDataSourceImpl implements RSSPodcastDataSource {
  RSSPodcastDataSourceImpl();
  final RSSFeedClient _client = RSSFeedClient(
    httpClient: Dio(
      BaseOptions(
        validateStatus: (status) =>
            status != null && (status >= 200 && status < 300 || status == 304),
      ),
    ),
  );
  final FeedDao _feedDao = locator<FeedDao>();

  @override
  Future<AppEither<RSSPodcastFeed>> getFeed(String url) async {
    final uri = Uri.parse(url);

    final FeedRow? cached = await _feedDao.getByUrl(url);

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
        .flatMap((response) => _handleResponse(uri, response, cached))
        .run();
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

    return _parseFeed(url, body).flatMap(
      (parsed) => _persistOrReuseCache(url, response, parsed, cached),
    );
  }

  AppTaskEither<RSSPodcastFeed> _persistOrReuseCache(
    Uri url,
    Response<String> response,
    ({String hash, RSSPodcastFeed feed}) parsed,
    FeedRow? cached,
  ) {
    if (cached != null && cached.contentHash == parsed.hash) {
      return _mapFeedRow(cached);
    }

    return TaskEither.tryCatch(
      () async {
        final feed = parsed.feed;
        if (!_isValidFeed(feed)) {
          throw ValidationException('Invalid rss feed: $url');
        }

        final feedId = await _feedDao.upsertFeed(
          FeedsCompanion.insert(
            url: url.toString(),
            etag: Value(response.headers.value('etag')),
            lastModified: Value(response.headers.value('last-modified')),
            contentHash: Value(parsed.hash),
            title: parsed.feed.title!,
            host: parsed.feed.ownerName!,
            imageUrl: parsed.feed.imageUrl!,
            description: parsed.feed.description ?? '',
            fetchedAt: DateTime.now(),
          ),
        );

        await _feedDao.upsertEpisodes(
          feedId,
          parsed.feed.episodes
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

        return parsed.feed;
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

  AppTaskEither<({String hash, RSSPodcastFeed feed})> _parseFeed(
    Uri url,
    String body,
  ) {
    if (kDebugMode) {
      logarte.log('Parsing rss feed: $url');
    }
    return TaskEither.tryCatch(
      () => Isolate.run(() => RSSFeedClient.parseFeedWithHash((url, body))),
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
      final epRows = await _feedDao.getEpisodesByFeedId(row.id);
      final episodes = epRows.map(_mapEpisodeRow).toList();

      return RSSPodcastFeed(
        url: Uri.tryParse(row.url),
        title: row.title,
        ownerName: row.host,
        imageUrl: row.imageUrl,
        description: row.description,
        episodes: episodes,
      );
    }, (error, stackTrace) => CacheError(error.toString()));
  }

  RSSFeedEpisode _mapEpisodeRow(EpisodeRow row) {
    return RSSFeedEpisode(
      title: row.title,
      publishedAt: row.pubDate,
      audioUrl: row.audioUrl,
      duration: Duration(seconds: row.totalSeconds),
      imageUrl: row.imageUrl,
    );
  }

  @override
  FutureOr<void> close() {
    _client.close();
  }
}

class ValidationException implements Exception {
  ValidationException(this.message);
  final String message;
}
