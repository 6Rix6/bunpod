import 'package:bunpod/bunpod.dart';
import 'package:drift/drift.dart';

part 'episode_dao.g.dart';

@DriftAccessor(tables: [Episodes])
class EpisodeDao extends DatabaseAccessor<AppDatabase> with _$EpisodeDaoMixin {
  EpisodeDao(super.db);

  Future<List<EpisodeRow>> getAll() {
    return select(episodes).get();
  }

  Stream<List<EpisodeRow>> watchAll() {
    return select(episodes).watch();
  }

  Future<EpisodeRow> getById(int id) {
    return (select(episodes)..where((row) => row.id.equals(id))).getSingle();
  }

  Stream<EpisodeRow> watchById(int id) {
    return (select(episodes)..where((row) => row.id.equals(id))).watchSingle();
  }
}
