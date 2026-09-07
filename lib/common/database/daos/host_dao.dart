import 'package:bunpod/bunpod.dart';
import 'package:drift/drift.dart';

part 'host_dao.g.dart';

@DriftAccessor(tables: [Hosts, Feeds])
class HostDao extends DatabaseAccessor<AppDatabase> with _$HostDaoMixin {
  HostDao(super.db);

  Stream<List<HostRow>> watchAll() {
    return select(hosts).watch();
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

  Future<List<FeedRow>> getFeedsByHostId(int hostId) {
    return (select(feeds)..where((row) => row.hostId.equals(hostId))).get();
  }
}
