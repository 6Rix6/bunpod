import 'package:drift/drift.dart';
import 'package:bunpod/bunpod.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Feeds, Categories, FeedCategories, SubscribedChannels])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(super.db);

  Future<CategoryRow> getById(int id) async {
    return (select(categories)..where((row) => row.id.equals(id))).getSingle();
  }

  Future<List<CategoryRow>> getAll() async {
    return await select(categories).get();
  }

  Stream<List<CategoryRow>> watchAll() {
    return select(categories).watch();
  }

  Stream<List<CategoryRow>> watchSubscribed() {
    final query = select(categories).join([
      innerJoin(
        feedCategories,
        feedCategories.categoryId.equalsExp(categories.id),
      ),
      innerJoin(
        subscribedChannels,
        subscribedChannels.feedId.equalsExp(feedCategories.feedId),
      ),
    ])..groupBy([categories.id]);

    return query.watch().map(
      (rows) => rows.map((row) => row.readTable(categories)).toList(),
    );
  }

  Future<void> addCategoryToFeed(int feedId, int categoryId) {
    return into(feedCategories).insert(
      FeedCategoriesCompanion.insert(feedId: feedId, categoryId: categoryId),
      mode: InsertMode.insertOrIgnore,
    );
  }

  Future<void> removeCategoryFromFeed(int feedId, int categoryId) {
    return (delete(feedCategories)..where(
          (tbl) =>
              tbl.feedId.equals(feedId) & tbl.categoryId.equals(categoryId),
        ))
        .go();
  }

  Future<List<CategoryRow>> getCategoriesForFeed(int feedId) {
    final query = select(categories).join([
      innerJoin(
        feedCategories,
        feedCategories.categoryId.equalsExp(categories.id),
      ),
    ])..where(feedCategories.feedId.equals(feedId));

    return query.map((row) => row.readTable(categories)).get();
  }

  Future<List<FeedRow>> getFeedsForCategory(int categoryId) {
    final query = select(feeds).join([
      innerJoin(feedCategories, feedCategories.feedId.equalsExp(feeds.id)),
    ])..where(feedCategories.categoryId.equals(categoryId));

    return query.map((row) => row.readTable(feeds)).get();
  }

  Future<List<FeedRow>> getSubscribedFeedsForCategory(int categoryId) {
    final query =
        select(feeds).join([
            innerJoin(
              subscribedChannels,
              subscribedChannels.feedId.equalsExp(feeds.id),
            ),
            innerJoin(
              feedCategories,
              feedCategories.feedId.equalsExp(feeds.id),
            ),
          ])
          ..where(feedCategories.categoryId.equals(categoryId))
          ..orderBy([OrderingTerm.asc(subscribedChannels.sortOrder)]);

    return query.map((row) => row.readTable(feeds)).get();
  }

  Stream<List<CategoryRow>> watchCategoriesForFeed(int feedId) {
    final query = select(categories).join([
      innerJoin(
        feedCategories,
        feedCategories.categoryId.equalsExp(categories.id),
      ),
    ])..where(feedCategories.feedId.equals(feedId));

    return query.map((row) => row.readTable(categories)).watch();
  }

  Future<void> setCategoriesForFeed(int feedId, List<int> categoryIds) {
    return transaction(() async {
      await (delete(
        feedCategories,
      )..where((tbl) => tbl.feedId.equals(feedId))).go();
      for (final categoryId in categoryIds) {
        await addCategoryToFeed(feedId, categoryId);
      }
    });
  }

  Future<void> attachCategoriesByNameToFeed(
    int feedId,
    List<String> categoryNames,
  ) async {
    final uniqueNames = categoryNames.toSet().toList();
    if (uniqueNames.isEmpty) return;

    await transaction(() async {
      await batch((b) {
        b.insertAll(
          categories,
          uniqueNames
              .map((name) => CategoriesCompanion.insert(name: name))
              .toList(),
          mode: InsertMode.insertOrIgnore,
        );
      });

      final rows = await (select(
        categories,
      )..where((tbl) => tbl.name.isIn(uniqueNames))).get();

      await batch((b) {
        b.insertAll(
          feedCategories,
          rows
              .map(
                (row) => FeedCategoriesCompanion.insert(
                  feedId: feedId,
                  categoryId: row.id,
                ),
              )
              .toList(),
          mode: InsertMode.insertOrIgnore,
        );
      });
    });
  }
}
