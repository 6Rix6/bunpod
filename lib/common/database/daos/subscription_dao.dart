import 'package:bunpod/bunpod.dart';
import 'package:drift/drift.dart';

part 'subscription_dao.g.dart';

typedef SubscribedChannelWithFeed = ({
  SubscribedChannelRow subscription,
  FeedRow feed,
});

@DriftAccessor(tables: [SubscribedChannels, Feeds])
class SubscriptionDao extends DatabaseAccessor<AppDatabase>
    with _$SubscriptionDaoMixin {
  SubscriptionDao(super.db);

  Future<bool> isSubscribed(int feedId) async {
    final row = await (select(
      subscribedChannels,
    )..where((s) => s.feedId.equals(feedId))).getSingleOrNull();
    return row != null;
  }

  Stream<bool> watchIsSubscribed(int feedId) {
    final query = select(subscribedChannels)
      ..where((s) => s.feedId.equals(feedId));
    return query.watchSingleOrNull().map((row) => row != null);
  }

  Future<bool> isSubscribedByUrl(String url) async {
    final query = select(subscribedChannels).join([
      innerJoin(feeds, feeds.id.equalsExp(subscribedChannels.feedId)),
    ])..where(feeds.url.equals(url));

    final row = await query.getSingleOrNull();
    return row != null;
  }

  Stream<bool> watchIsSubscribedByUrl(String url) {
    final query = select(subscribedChannels).join([
      innerJoin(feeds, feeds.id.equalsExp(subscribedChannels.feedId)),
    ])..where(feeds.url.equals(url));

    return query.watchSingleOrNull().map((row) => row != null);
  }

  Future<void> subscribe(int feedId) async {
    final maxOrder = await _maxSortOrder();
    await into(subscribedChannels).insert(
      SubscribedChannelsCompanion.insert(
        feedId: feedId,
        subscribedAt: DateTime.now(),
        sortOrder: Value(maxOrder + 1),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }

  Future<void> unsubscribe(int feedId) {
    return (delete(
      subscribedChannels,
    )..where((s) => s.feedId.equals(feedId))).go();
  }

  Future<void> subscribeByUrl(String url) async {
    final feedId = await _feedIdByUrl(url);
    if (feedId == null) {
      throw StateError('Feed not found for url: $url');
    }
    await subscribe(feedId);
  }

  Future<void> unsubscribeByUrl(String url) async {
    final feedId = await _feedIdByUrl(url);
    if (feedId == null) return;
    await unsubscribe(feedId);
  }

  Future<int?> _feedIdByUrl(String url) async {
    final feed = await (select(
      feeds,
    )..where((f) => f.url.equals(url))).getSingleOrNull();
    return feed?.id;
  }

  Future<int> _maxSortOrder() async {
    final query = selectOnly(subscribedChannels)
      ..addColumns([subscribedChannels.sortOrder.max()]);
    final row = await query.getSingleOrNull();
    return row?.read(subscribedChannels.sortOrder.max()) ?? 0;
  }

  Stream<List<SubscribedChannelWithFeed>> watchSubscribedChannels() {
    final query = select(subscribedChannels).join([
      innerJoin(feeds, feeds.id.equalsExp(subscribedChannels.feedId)),
    ])..orderBy([OrderingTerm.asc(subscribedChannels.sortOrder)]);

    return query.watch().map(
      (rows) => rows
          .map(
            (row) => (
              subscription: row.readTable(subscribedChannels),
              feed: row.readTable(feeds),
            ),
          )
          .toList(),
    );
  }
}
