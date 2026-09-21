import 'package:bunpod/bunpod.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Feeds,
    Hosts,
    Episodes,
    SubscribedChannels,
    PlaybackProgress,
    Categories,
    FeedCategories,
  ],
  daos: [
    FeedDao,
    HostDao,
    SubscriptionDao,
    PlaybackDao,
    CategoryDao,
    EpisodeDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: AppValues.databaseName,
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
