import 'package:bunpod/bunpod.dart';

abstract interface class PlaybackProgressRepository {
  Stream<Duration?> watchProgress(int episodeId);
  AppTaskEither<void> updateProgress(int episodeId, Duration listened);
}

class PlaybackProgressRepositoryImpl implements PlaybackProgressRepository {
  const PlaybackProgressRepositoryImpl(this._dao);
  final PlaybackDao _dao;

  @override
  Stream<Duration?> watchProgress(int episodeId) {
    return _dao
        .watchProgress(episodeId)
        .map(
          (data) =>
              data != null ? Duration(seconds: data.listenedSeconds) : null,
        );
  }

  @override
  AppTaskEither<void> updateProgress(int episodeId, Duration listened) {
    return AppTaskEither.tryCatch(
      () => _dao.updateProgress(episodeId, listened.inSeconds),
      (error, _) => CacheError(error.toString()),
    );
  }
}
