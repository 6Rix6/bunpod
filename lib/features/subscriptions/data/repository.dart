import 'package:bunpod/bunpod.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class SubscriptionRepository {
  Stream<bool> watchIsSubscribed(String url);
  AppTaskEither<bool> isSubscribed(String url);
  AppTaskEither<void> subscribe(String url);
  AppTaskEither<void> unsubscribe(String url);
}

abstract interface class SubscribedChannelsRepository {
  AppTaskEither<List<String>> getFeedUrls();
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
  AppTaskEither<List<String>> getFeedUrls() {
    return TaskEither.tryCatch(() async {
      final rows = await _dao.getSubscribedChannels();
      return rows.map((row) => row.feed.url).toList();
    }, (error, _) => AppError.cache(error.toString()));
  }
}
