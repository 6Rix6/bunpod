import 'package:bunpod/bunpod.dart';
import 'package:drift/drift.dart';

part 'feed_dao.g.dart';

@DriftAccessor(tables: [Feeds, Episodes])
class FeedDao extends DatabaseAccessor<AppDatabase> with _$FeedDaoMixin {
  FeedDao(super.db);

  /// Retrieves the cached feed from the URL (including previews of unsubscribed feeds)
  Future<FeedRow?> getByUrl(String url) {
    return (select(feeds)..where((f) => f.url.equals(url))).getSingleOrNull();
  }

  Future<FeedRow?> getById(int id) {
    return (select(feeds)..where((f) => f.id.equals(id))).getSingleOrNull();
  }

  /// On successful retrieval: upserts the feed metadata and returns the ID
  Future<int> upsertFeed(FeedsCompanion companion) async {
    final row = await into(feeds).insertReturning(
      companion,
      onConflict: DoUpdate(
        (old) => companion,
        target: [feeds.url],
      ),
    );

    return row.id;
  }

  /// Upserts the episodes (based on guid).
  Future<void> upsertEpisodes(int feedId, List<EpisodesCompanion> episodes) {
    return batch((b) {
      for (final episode in episodes) {
        b.insert(
          this.episodes,
          episode.copyWith(feedId: Value(feedId)),
          onConflict: DoUpdate((_) => episode.copyWith(feedId: Value(feedId))),
        );
      }
    });
  }

  /// List of episodes under feedId
  Future<List<EpisodeRow>> getEpisodesByFeedId(int feedId) {
    return (select(episodes)
          ..where((e) => e.feedId.equals(feedId))
          ..orderBy([(e) => OrderingTerm.desc(e.pubDate)]))
        .get();
  }

  Stream<List<EpisodeRow>> watchEpisodesByFeedId(int feedId) {
    return (select(episodes)
          ..where((e) => e.feedId.equals(feedId))
          ..orderBy([(e) => OrderingTerm.desc(e.pubDate)]))
        .watch();
  }
}
