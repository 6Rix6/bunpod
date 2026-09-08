// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dao.dart';

// ignore_for_file: type=lint
mixin _$CategoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $HostsTable get hosts => attachedDatabase.hosts;
  $FeedsTable get feeds => attachedDatabase.feeds;
  $CategoriesTable get categories => attachedDatabase.categories;
  $FeedCategoriesTable get feedCategories => attachedDatabase.feedCategories;
  $SubscribedChannelsTable get subscribedChannels =>
      attachedDatabase.subscribedChannels;
  CategoryDaoManager get managers => CategoryDaoManager(this);
}

class CategoryDaoManager {
  final _$CategoryDaoMixin _db;
  CategoryDaoManager(this._db);
  $$HostsTableTableManager get hosts =>
      $$HostsTableTableManager(_db.attachedDatabase, _db.hosts);
  $$FeedsTableTableManager get feeds =>
      $$FeedsTableTableManager(_db.attachedDatabase, _db.feeds);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$FeedCategoriesTableTableManager get feedCategories =>
      $$FeedCategoriesTableTableManager(
        _db.attachedDatabase,
        _db.feedCategories,
      );
  $$SubscribedChannelsTableTableManager get subscribedChannels =>
      $$SubscribedChannelsTableTableManager(
        _db.attachedDatabase,
        _db.subscribedChannels,
      );
}
