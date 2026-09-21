// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_dao.dart';

// ignore_for_file: type=lint
mixin _$EpisodeDaoMixin on DatabaseAccessor<AppDatabase> {
  $HostsTable get hosts => attachedDatabase.hosts;
  $FeedsTable get feeds => attachedDatabase.feeds;
  $EpisodesTable get episodes => attachedDatabase.episodes;
  EpisodeDaoManager get managers => EpisodeDaoManager(this);
}

class EpisodeDaoManager {
  final _$EpisodeDaoMixin _db;
  EpisodeDaoManager(this._db);
  $$HostsTableTableManager get hosts =>
      $$HostsTableTableManager(_db.attachedDatabase, _db.hosts);
  $$FeedsTableTableManager get feeds =>
      $$FeedsTableTableManager(_db.attachedDatabase, _db.feeds);
  $$EpisodesTableTableManager get episodes =>
      $$EpisodesTableTableManager(_db.attachedDatabase, _db.episodes);
}
