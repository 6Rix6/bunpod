import 'package:apple_podcast_api/src/client/base_handler.dart';
import 'package:apple_podcast_api/src/utils/feed_mapper.dart';
import 'package:apple_podcast_api/src/models/api_failure.dart';
import 'package:apple_podcast_api/src/models/itunes_podcast.dart';
import 'package:apple_podcast_api/src/models/rss_podcast_feed.dart';
import 'package:apple_podcast_api/src/models/types.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rss_dart/dart_rss.dart';

/// A client for fetching and parsing podcast RSS feeds.
///
/// Wraps HTTP requests via [BaseHandler] and converts the response body
/// into a [RSSPodcastFeed]. Provides both direct [Uri]-based methods
/// ([fetchFeed], [fetchFeedRaw]) and convenience methods that resolve the
/// feed URL from an [ItunesPodcast] ([fetchFeedFor], [fetchFeedRawFor]).
class RSSFeedClient {
  RSSFeedClient({Dio? httpClient})
    : _handler = BaseHandler(httpClient: httpClient);

  final BaseHandler _handler;

  /// Fetches and parses the RSS feed at [feedUrl].
  ///
  /// Malformed XML or a missing channel element results in a
  /// [ParseFailure]; individual missing tags simply stay `null`.
  ApiResult<RSSPodcastFeed> fetchFeed(Uri feedUrl) {
    return _fetchFeedRaw(feedUrl)
        .flatMap((body) => parseFeedTask(feedUrl, body))
        .run();
  }

  /// Fetches the RSS feed at [feedUrl] and returns the raw response body
  /// without parsing it into a [RSSPodcastFeed].
  ApiResult<String> fetchFeedRaw(Uri feedUrl) {
    return _fetchFeedRaw(feedUrl).run();
  }

  TaskEither<ApiFailure, String> _fetchFeedRaw(Uri feedUrl) {
    return _handler.getPlainText(feedUrl);
  }

  /// Convenience wrapper around [fetchFeed] using the [ItunesPodcast.feedUrl].
  ApiResult<RSSPodcastFeed> fetchFeedFor(ItunesPodcast show) {
    return _resolveFeedUri(show).match(
      (failure) => Future.value(Either.left(failure)),
      (uri) => fetchFeed(uri),
    );
  }

  /// Convenience wrapper around [fetchFeedRaw] using the [Podcast.feedUrl].
  ApiResult<String> fetchFeedRawFor(ItunesPodcast show) {
    return _resolveFeedUri(show).match(
      (failure) => Future.value(Either.left(failure)),
      (uri) => fetchFeedRaw(uri),
    );
  }

  /// Parses XML string, returning either a [ParseFailure]
  /// or the converted [RSSPodcastFeed].
  static TaskEither<ApiFailure, RSSPodcastFeed> parseFeedTask(
    Uri url,
    String body,
  ) {
    return TaskEither.tryCatch(
      () async => parseFeed((url, body)),
      (error, stackTrace) => ParseFailure(error, stackTrace),
    );
  }

  /// Parses XML string, returning [RSSPodcastFeed]
  /// or throwing error when parse failed.
  static RSSPodcastFeed parseFeed((Uri url, String body) args) {
    return mapRssFeed(args.$1, RssFeed.parse(args.$2));
  }

  /// Validates and parses [show.feedUrl], returning either a [ParseFailure]
  /// or the resolved [Uri].
  Either<ParseFailure, Uri> _resolveFeedUri(ItunesPodcast show) {
    final raw = show.feedUrl;
    if (raw == null || raw.isEmpty) {
      return Either.left(const ParseFailure('Show has no feed URL', null));
    }
    final uri = Uri.tryParse(raw);
    if (uri == null) {
      return Either.left(ParseFailure('Invalid feed URL: $raw', null));
    }
    return Either.right(uri);
  }

  void close() => _handler.close();
}
