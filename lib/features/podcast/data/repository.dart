import 'dart:async';

import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:bunpod/bunpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pool/pool.dart';

abstract interface class PodcastFeedRepository {
  AppTaskEither<PodcastFeed> fetchFeed(String url);
  Future<AppEither<List<PodcastFeed>>> fetchFeeds(List<String> urls);
  FutureOr<void> close();
}

class PodcastFeedRepositoryImpl implements PodcastFeedRepository {
  PodcastFeedRepositoryImpl(this._datasource);
  final RSSPodcastDataSource _datasource;

  // TODO: customizable resource count
  final Pool _pool = Pool(4);

  @override
  AppTaskEither<PodcastFeed> fetchFeed(String url) {
    return _datasource
        .getFeed(url)
        .flatMap(
          (feed) => TaskEither<AppError, PodcastFeed>(() async {
            final parsed = await feed.toPodcastFeed(url);

            if (parsed == null) {
              return Either.left(
                ParseError(
                  'Failed to convert RSSPodcastFeed: $feed',
                  StackTrace.current,
                ),
              );
            }

            return Either.right(parsed);
          }),
        );
  }

  @override
  Future<AppEither<List<PodcastFeed>>> fetchFeeds(List<String> urls) async {
    final futures = urls.map(
      (url) => _pool.withResource(() => _datasource.getFeed(url).run()),
    );
    final results = await Future.wait(futures);

    final rssFeeds = <(String, RSSPodcastFeed)>[];
    final errors = <AppError>[];

    for (var i = 0; i < urls.length; i++) {
      results[i].match(
        (e) {
          logarte.log('failed to fetch feed: $e');
          errors.add(e);
        },
        (rss) => rssFeeds.add((urls[i], rss)),
      );
    }

    if (rssFeeds.isEmpty && results.isNotEmpty) {
      return Either.left(MultipleError(errors));
    }

    final feeds = <PodcastFeed>[];
    for (final (url, rss) in rssFeeds) {
      final feed = await rss.toPodcastFeed(url);
      if (feed == null) {
        logarte.log('failed to convert RSSPodcastFeed: ${rss.url}');
        continue;
      }
      feeds.add(feed);
    }

    if (feeds.isEmpty && results.isNotEmpty) {
      return Either.left(
        ParseError('Failed to parse all rss feeds.', StackTrace.current),
      );
    }

    return Either.right(feeds);
  }

  @override
  FutureOr<void> close() async {
    await _pool.close();
  }
}
