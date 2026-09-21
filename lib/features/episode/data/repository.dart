import 'package:bunpod/bunpod.dart';

abstract interface class EpisodeRepository {
  AppTaskEither<Episode> getEpisodeForId(int id);
}

abstract interface class PlaybackProgressRepository {
  Stream<Duration?> watchProgress(int episodeId);
  AppTaskEither<void> updateProgress(int episodeId, Duration listened);
}

class EpisodeRepositoryImpl implements EpisodeRepository {
  const EpisodeRepositoryImpl(this._episodeDao, this._hostDao, this._feedDao);
  final EpisodeDao _episodeDao;
  final HostDao _hostDao;
  final FeedDao _feedDao;

  @override
  AppTaskEither<Episode> getEpisodeForId(int id) {
    return AppTaskEither.tryCatch(
      () async {
        final row = await _episodeDao.getById(id);
        final feedRow = await _feedDao.getById(row.feedId);
        final hostRow = await _hostDao.getById(feedRow.hostId);

        final color = await ImageColorCache.of(row.imageUrl);

        return Episode(
          localId: row.id,
          guid: row.guid,
          bucket: calculateBucket(row.pubDate),
          channel: feedRow.title,
          host: hostRow.name,
          title: row.title,
          date: row.pubDate.toIso8601String(),
          color: color,
          image: row.imageUrl,
          feedurl: feedRow.url,
          audioUrl: row.audioUrl,
          total: Duration(seconds: row.totalSeconds),
        );
      },
      (error, stackTrace) => CacheError(error.toString()),
    );
  }
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
