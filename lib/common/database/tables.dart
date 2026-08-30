import 'package:drift/drift.dart';

@DataClassName('FeedRow')
class Feeds extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get url => text().unique()();
  TextColumn get etag => text().nullable()();
  TextColumn get lastModified => text().nullable()();
  TextColumn get contentHash => text().nullable()();
  TextColumn get title => text()();
  TextColumn get host => text()();
  TextColumn get imageUrl => text()();
  TextColumn get description => text()();
  DateTimeColumn get fetchedAt => dateTime()();
}

@DataClassName('SubscribedChannelRow')
class SubscribedChannels extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get feedId => integer().references(Feeds, #id).unique()();
  DateTimeColumn get subscribedAt => dateTime()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(true))();
}

@DataClassName('EpisodeRow')
class Episodes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get feedId => integer().references(Feeds, #id)();
  TextColumn get guid => text()();
  TextColumn get title => text()();
  TextColumn get imageUrl => text().nullable()();
  DateTimeColumn get pubDate => dateTime()();
  TextColumn get audioUrl => text()();
  IntColumn get totalSeconds => integer()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {feedId, guid},
  ];
}

@DataClassName('PlaybackProgressRow')
class PlaybackProgress extends Table {
  IntColumn get episodeId => integer().references(Episodes, #id)();
  IntColumn get listenedSeconds => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {episodeId};
}
