import 'dart:async';

import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:bunpod/bunpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pool/pool.dart';

abstract interface class PodcastFeedRepository {
  Future<AppEither<List<PodcastFeed>>> fetchFeeds();
  FutureOr<void> close();
}

const _debugUrls = [
  'https://www.omnycontent.com/d/playlist/67122501-9b17-4d77-84bd-a93d00dc791e/3551f0c9-79eb-4ca9-9e0e-b38700916820/8742367b-b8c0-414a-91d9-b3c9006daddd/podcast.rss',
  'https://feeds.megaphone.fm/TAC9650125234',
];

class PodcastFeedRepositoryImpl implements PodcastFeedRepository {
  PodcastFeedRepositoryImpl(this._datasource);
  final RSSPodcastDataSource _datasource;

  // TODO: customizable resource count
  final Pool _pool = Pool(4);

  @override
  Future<AppEither<List<PodcastFeed>>> fetchFeeds() async {
    final futures = _debugUrls.map(
      (url) => _pool.withResource(() => _datasource.getFeed(url)),
    );
    final results = await Future.wait(futures);

    final rssFeeds = <RSSPodcastFeed>[];
    final errors = <AppError>[];

    for (final result in results) {
      result.match(
        (e) {
          logarte.log('failed to fetch feed: $e');
          errors.add(e);
        },
        rssFeeds.add,
      );
    }

    if (rssFeeds.isEmpty && results.isNotEmpty) {
      return Either.left(MultipleError(errors));
    }

    final feeds = <PodcastFeed>[];
    for (final rss in rssFeeds) {
      final feed = await rss.toPodcastFeed();
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
