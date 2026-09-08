import 'package:bunpod/bunpod.dart';
import 'package:drift/drift.dart';

part 'host_dao.g.dart';

@DriftAccessor(tables: [Hosts, Feeds, SubscribedChannels])
class HostDao extends DatabaseAccessor<AppDatabase> with _$HostDaoMixin {
  HostDao(super.db);

  Stream<List<HostRow>> watchAll() {
    return select(hosts).watch();
  }

  Stream<List<HostRow>> watchSubscribed() {
    final query = select(hosts).join([
      innerJoin(
        feeds,
        feeds.hostId.equalsExp(hosts.id),
      ),
      innerJoin(
        subscribedChannels,
        subscribedChannels.feedId.equalsExp(feeds.id),
      ),
    ])..groupBy([hosts.id]);

    return query.watch().map(
      (rows) => rows.map((row) => row.readTable(hosts)).toList(),
    );
  }

  Future<HostRow> getById(int id) {
    return (select(hosts)..where((row) => row.id.equals(id))).getSingle();
  }

  Future<int> upsertHost(HostsCompanion companion) async {
    final row = await into(hosts).insertReturning(
      companion,
      onConflict: DoUpdate(
        (old) => companion,
        target: [hosts.name],
      ),
    );

    return row.id;
  }

  Future<List<FeedRow>> getFeedsForHost(int hostId) {
    return (select(feeds)..where((row) => row.hostId.equals(hostId))).get();
  }

  Future<List<FeedRow>> getSubscribedFeedsForHost(int hostId) {
    final query =
        select(feeds).join([
            innerJoin(
              subscribedChannels,
              subscribedChannels.feedId.equalsExp(feeds.id),
            ),
          ])
          ..where(feeds.hostId.equals(hostId))
          ..orderBy([OrderingTerm.asc(subscribedChannels.sortOrder)]);

    return query.map((row) => row.readTable(feeds)).get();
  }
}
