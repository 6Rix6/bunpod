import 'package:apple_podcast_api/apple_podcast_api.dart' as api;
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:bunpod/bunpod.dart';

abstract interface class SearchRepository {
  AppTaskEither<List<SearchResultItem>> search(String query);
  AppTaskEither<List<SearchResultItem>> searchByCategory(String query);
  AppTaskEither<List<SearchResultItem>> searchByHost(String query);
}

class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl(this._client);

  final api.ItunesPodcastApi _client;

  @override
  AppTaskEither<List<SearchResultItem>> search(String query) {
    return TaskEither(
      () => _client.search(query, entity: .podcast),
    ).mapLeft(_mapError).flatMap(_handleResponse);
  }

  @override
  AppTaskEither<List<SearchResultItem>> searchByCategory(
    String query,
  ) {
    return TaskEither(
      () => _client.search(query, attribute: .keywordsTerm),
    ).mapLeft(_mapError).flatMap(_handleResponse);
  }

  @override
  AppTaskEither<List<SearchResultItem>> searchByHost(String query) {
    return TaskEither(
      () => _client.search(query, attribute: .authorTerm),
    ).mapLeft(_mapError).flatMap(_handleResponse);
  }

  AppTaskEither<List<SearchResultItem>> _handleResponse(
    Response<api.SearchResponse> response,
  ) {
    final data = response.data;

    if (data == null) {
      return TaskEither.left(
        ParseError('Response body is empty', StackTrace.current),
      );
    }

    final List<SearchResultItem> results = [];

    for (final podcast in data.podcasts) {
      if (podcast.feedUrl == null) {
        logarte.log('No podcast rss feed url found: $podcast');
        continue;
      }

      final channel = podcast.toChannel();
      if (channel != null) {
        final item = SearchResultItem(
          channel: channel,
          feedUrl: podcast.feedUrl!,
        );
        results.add(item);
      } else {
        logarte.log('failed to convert ItunesPodcast: $podcast');
      }
    }

    return TaskEither.right(results);
  }

  AppError _mapError(api.ApiFailure failure) {
    return switch (failure) {
      api.NetworkFailure f => NetworkError(f.message, cause: f.cause),
      api.CancelledFailure() => CancelledError(),
      api.HttpFailure f => HttpError(
        statusCode: f.statusCode,
        message: f.message,
        responseBody: f.responseBody,
      ),
      api.ParseFailure f => ParseError(f.message, f.stackTrace),
      api.UnknownFailure f => UnknownError(f.error, f.stackTrace),
    };
  }
}

abstract interface class CategoryRepository {
  Stream<List<int>> watchCategories();
  AppTaskEither<ExploreCategory> getExploreCategory(int id);
}

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl(this._categoryDao, this._hostDao);
  final CategoryDao _categoryDao;
  final HostDao _hostDao;

  @override
  Stream<List<int>> watchCategories() {
    return _categoryDao.watchAll().map(
      (rows) => rows.map((row) => row.id).toList(),
    );
  }

  @override
  AppTaskEither<ExploreCategory> getExploreCategory(int id) {
    return TaskEither.tryCatch(() async {
      final row = await _categoryDao.getById(id);
      final feedRows = await _categoryDao.getFeedsForCategory(id);
      final channels = await Future.wait(feedRows.map(_mapFeedRow));

      return ExploreCategory(
        name: row.name,
        color: channels.firstOrNull?.color ?? ImageColorCache.defaultColor,
        channels: channels,
      );
    }, (error, _) => CacheError(error.toString()));
  }

  Future<Channel> _mapFeedRow(FeedRow row) async {
    final host = await _hostDao.getById(row.hostId);
    return row.toChannel(host.name);
  }
}

abstract interface class HostsRepository {
  Stream<List<int>> watchHosts();
  AppTaskEither<ExploreHost> getExploreHost(int id);
}

class HostsRepositoryImpl implements HostsRepository {
  const HostsRepositoryImpl(this._hostDao);
  final HostDao _hostDao;

  @override
  Stream<List<int>> watchHosts() {
    return _hostDao.watchAll().map(
      (rows) => rows.map((row) => row.id).toList(),
    );
  }

  @override
  AppTaskEither<ExploreHost> getExploreHost(int id) {
    return TaskEither.tryCatch(() async {
      final row = await _hostDao.getById(id);
      final feedRows = await _hostDao.getFeedsByHostId(id);
      final channels = await Future.wait(feedRows.map(_mapFeedRow));

      return ExploreHost(
        name: row.name,
        color: channels.firstOrNull?.color ?? ImageColorCache.defaultColor,
        channels: channels,
      );
    }, (error, _) => CacheError(error.toString()));
  }

  Future<Channel> _mapFeedRow(FeedRow row) async {
    final host = await _hostDao.getById(row.hostId);
    return row.toChannel(host.name);
  }
}
