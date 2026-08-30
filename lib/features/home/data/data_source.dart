import 'dart:isolate';
import 'dart:async';

import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:bunpod/bunpod.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RSSPodcastDataSource {
  Future<AppEither<RSSPodcastFeed>> getFeed(String url);
  FutureOr<void> close();
}

class RSSPodcastDataSourceImpl implements RSSPodcastDataSource {
  RSSPodcastDataSourceImpl();
  final RSSFeedClient _client = RSSFeedClient();

  @override
  Future<AppEither<RSSPodcastFeed>> getFeed(String url) async {
    final uri = Uri.parse(url);

    return TaskEither(
      () => _client.fetchFeedRaw(uri),
    ).mapLeft(_mapError).flatMap((body) => _parseFeed(uri, body)).run();
  }

  AppTaskEither<RSSPodcastFeed> _parseFeed(Uri url, String body) {
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

  @override
  FutureOr<void> close() {
    _client.close();
  }
}
