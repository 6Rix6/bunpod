import 'package:bunpod/bunpod.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class SubscriptionRepository {
  Stream<bool> watchIsSubscribed(String url);
  AppTaskEither<bool> isSubscribed(String url);
  AppTaskEither<void> subscribe(String url);
  AppTaskEither<void> unsubscribe(String url);
}

abstract interface class SubscribedChannelsRepository {
  Stream<List<int>> watchSubscribedChannelIds();
  AppTaskEither<List<int>> getSubscribedChannelIds();
  AppTaskEither<List<String>> getFeedUrls();
}

abstract interface class ChannelsRepository {
  AppTaskEither<Channel> getChannelById(int id);
}

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  const SubscriptionRepositoryImpl(this._dao);

  final SubscriptionDao _dao;

  @override
  Stream<bool> watchIsSubscribed(String url) {
    return _dao.watchIsSubscribedByUrl(url);
  }

  @override
  AppTaskEither<bool> isSubscribed(String url) {
    return TaskEither.tryCatch(
      () => _dao.isSubscribedByUrl(url),
      (error, stackTrace) => CacheError(error.toString()),
    );
  }

  @override
  AppTaskEither<void> subscribe(String url) {
    return TaskEither.tryCatch(
      () => _dao.subscribeByUrl(url),
      (error, stackTrace) => CacheError(error.toString()),
    );
  }

  @override
  AppTaskEither<void> unsubscribe(String url) {
    return TaskEither.tryCatch(
      () => _dao.unsubscribeByUrl(url),
      (error, stackTrace) => CacheError(error.toString()),
    );
  }
}

class SubscribedChannelsRepositoryImpl implements SubscribedChannelsRepository {
  const SubscribedChannelsRepositoryImpl(this._dao);
  final SubscriptionDao _dao;

  @override
  Stream<List<int>> watchSubscribedChannelIds() {
    return _dao.watchAll().map(
      (rows) => rows.map((row) => row.feedId).toList(),
    );
  }

  @override
  AppTaskEither<List<int>> getSubscribedChannelIds() {
    return AppTaskEither.tryCatch(() async {
      final rows = await _dao.getAll();
      return rows.map((row) => row.feedId).toList();
    }, (error, _) => CacheError(error.toString()));
  }

  @override
  AppTaskEither<List<String>> getFeedUrls() {
    return TaskEither.tryCatch(() async {
      final rows = await _dao.getSubscribedChannels();
      return rows.map((row) => row.feed.url).toList();
    }, (error, _) => CacheError(error.toString()));
  }
}

class ChannelsRepositoryImpl implements ChannelsRepository {
  const ChannelsRepositoryImpl(this._feedDao, this._hostDao);
  final FeedDao _feedDao;
  final HostDao _hostDao;

  @override
  AppTaskEither<Channel> getChannelById(int id) {
    return AppTaskEither.tryCatch(() async {
      final feedRow = await _feedDao.getById(id);
      final hostRow = await _hostDao.getById(feedRow.hostId);

      return await feedRow.toChannel(hostRow.name);
    }, (error, stackTrace) => CacheError(error.toString()));
  }
}
