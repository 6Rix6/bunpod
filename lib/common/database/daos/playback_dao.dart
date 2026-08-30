import 'package:bunpod/bunpod.dart';
import 'package:drift/drift.dart';

part 'playback_dao.g.dart';

@DriftAccessor(tables: [PlaybackProgress])
class PlaybackDao extends DatabaseAccessor<AppDatabase>
    with _$PlaybackDaoMixin {
  PlaybackDao(super.db);

  Future<void> updateProgress(int episodeId, int listenedSeconds) {
    return into(playbackProgress).insertOnConflictUpdate(
      PlaybackProgressCompanion.insert(
        episodeId: Value(episodeId),
        listenedSeconds: Value(listenedSeconds),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<PlaybackProgressRow?> getProgress(int episodeId) {
    return (select(
      playbackProgress,
    )..where((p) => p.episodeId.equals(episodeId))).getSingleOrNull();
  }

  Stream<PlaybackProgressRow?> watchProgress(int episodeId) {
    return (select(
      playbackProgress,
    )..where((p) => p.episodeId.equals(episodeId))).watchSingleOrNull();
  }
}
