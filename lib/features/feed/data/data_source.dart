import 'dart:isolate';
import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:bunpod/bunpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RSSPodcastDataSource {
  AppTaskEither<FeedFetchResult> getFeed(
    String url, {
    String? etag,
    String? lastModified,
    String? contentHash,
  });
}

sealed class FeedFetchResult {
  const FeedFetchResult();
}

class FeedNotModified extends FeedFetchResult {
  const FeedNotModified();
}

class FeedModified extends FeedFetchResult {
  const FeedModified({
    required this.feed,
    required this.etag,
    required this.lastModified,
    required this.contentHash,
  });

  final RSSPodcastFeed feed;
  final String? etag;
  final String? lastModified;
  final String contentHash;
}

class RSSPodcastDataSourceImpl implements RSSPodcastDataSource {
  const RSSPodcastDataSourceImpl(this._client);

  final RSSFeedClient _client;

  static BaseOptions get baseOptions => BaseOptions(
    validateStatus: (status) =>
        status != null && (status >= 200 && status < 300 || status == 304),
  );

  @override
  AppTaskEither<FeedFetchResult> getFeed(
    String url, {
    String? etag,
    String? lastModified,
    String? contentHash,
  }) {
    final uri = Uri.tryParse(url);

    if (uri == null) {
      return TaskEither.left(
        ParseError('Failed to parse url: $url', StackTrace.current),
      );
    }

    return TaskEither(
          () => _client.fetchFeedRaw(
            uri,
            headers: {
              'If-None-Match': ?etag,
              'If-Modified-Since': ?lastModified,
            },
          ),
        )
        .mapLeft(_mapError)
        .flatMap((response) => _handleResponse(uri, response, contentHash));
  }

  AppTaskEither<FeedFetchResult> _handleResponse(
    Uri url,
    Response<String> response,
    String? cachedHash,
  ) {
    if (response.statusCode == 304) {
      return TaskEither.right(const FeedNotModified());
    }

    final body = response.data;

    if (body == null || body.isEmpty) {
      return TaskEither.left(
        ParseError('Response body is empty', StackTrace.current),
      );
    }

    return _calcFeedHash(body).flatMap((hash) {
      if (hash == cachedHash) {
        return TaskEither.right(const FeedNotModified());
      }

      return _parseFeed(url, body).flatMap((feed) {
        if (!_isValidFeed(feed)) {
          return TaskEither.left(
            ParseError('Invalid rss feed: $url', StackTrace.current),
          );
        }

        return TaskEither.right(
          FeedModified(
            feed: feed,
            etag: response.headers.value('etag'),
            lastModified: response.headers.value('last-modified'),
            contentHash: hash,
          ),
        );
      });
    });
  }

  bool _isValidFeed(RSSPodcastFeed feed) {
    return feed.title != null &&
        feed.ownerName != null &&
        feed.imageUrl != null;
  }

  AppTaskEither<String> _calcFeedHash(String body) {
    return TaskEither.tryCatch(
      () => Isolate.run(() => RSSFeedClient.calcFeedHash(body)),
      (error, stackTrace) => ParseError(error, stackTrace),
    );
  }

  AppTaskEither<RSSPodcastFeed> _parseFeed(Uri url, String body) {
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
}
