// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_dao.dart';

// ignore_for_file: type=lint
mixin _$PlaybackDaoMixin on DatabaseAccessor<AppDatabase> {
  $FeedsTable get feeds => attachedDatabase.feeds;
  $EpisodesTable get episodes => attachedDatabase.episodes;
  $PlaybackProgressTable get playbackProgress =>
      attachedDatabase.playbackProgress;
  PlaybackDaoManager get managers => PlaybackDaoManager(this);
}

class PlaybackDaoManager {
  final _$PlaybackDaoMixin _db;
  PlaybackDaoManager(this._db);
  $$FeedsTableTableManager get feeds =>
      $$FeedsTableTableManager(_db.attachedDatabase, _db.feeds);
  $$EpisodesTableTableManager get episodes =>
      $$EpisodesTableTableManager(_db.attachedDatabase, _db.episodes);
  $$PlaybackProgressTableTableManager get playbackProgress =>
      $$PlaybackProgressTableTableManager(
        _db.attachedDatabase,
        _db.playbackProgress,
      );
}
