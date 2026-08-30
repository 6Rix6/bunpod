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
