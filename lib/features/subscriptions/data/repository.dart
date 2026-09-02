import 'package:bunpod/bunpod.dart';

abstract interface class SubscriptionRepository {
  Stream<bool> watchIsSubscribed(String url);
  Future<bool> isSubscribed(String url);
  Future<void> subscribe(String url);
  Future<void> unsubscribe(String url);
}

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  SubscriptionRepositoryImpl(this._dao);

  final SubscriptionDao _dao;

  @override
  Stream<bool> watchIsSubscribed(String url) {
    return _dao.watchIsSubscribedByUrl(url);
  }

  @override
  Future<bool> isSubscribed(String url) {
    return _dao.isSubscribedByUrl(url);
  }

  @override
  Future<void> subscribe(String url) {
    return _dao.subscribeByUrl(url);
  }

  @override
  Future<void> unsubscribe(String url) {
    return _dao.unsubscribeByUrl(url);
  }
}
