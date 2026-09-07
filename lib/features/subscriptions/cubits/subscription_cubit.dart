import 'dart:async';
import 'package:bunpod/bunpod.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SubscriptionCubit extends HydratedCubit<ViewState<bool>> {
  SubscriptionCubit(
    this._repository, {
    required String feedUrl,
  }) : _feedUrl = feedUrl,
       super(const ViewIdle()) {
    _subscribeToStream();
  }

  final SubscriptionRepository _repository;
  final String _feedUrl;
  StreamSubscription<bool>? _subscription;

  @override
  String get id => _feedUrl;

  void _subscribeToStream() {
    _subscription = _repository
        .watchIsSubscribed(_feedUrl)
        .listen(
          (isSubscribed) => emit(ViewReady(isSubscribed)),
          onError: (e) => emit(
            state.copyWithPrevious(ViewFailed(CacheError(e.toString()))),
          ),
        );
  }

  Future<void> subscribe() async {
    await _repository
        .subscribe(_feedUrl)
        .match(
          (error) => emit(state.copyWithPrevious(ViewFailed(error))),
          (_) {},
        )
        .run();
  }

  Future<void> unsubscribe() async {
    await _repository
        .unsubscribe(_feedUrl)
        .match(
          (error) => emit(state.copyWithPrevious(ViewFailed(error))),
          (_) {},
        )
        .run();
  }

  Future<void> toggle() async {
    final current = state;
    if (current is ViewBusy) return;

    final isSubscribed = current.dataOrNull == true;

    if (isSubscribed) {
      await unsubscribe();
    } else {
      await subscribe();
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  @override
  Map<String, dynamic>? toJson(ViewState<bool> state) =>
      state.toJson((value) => value);

  @override
  ViewState<bool>? fromJson(Map<String, dynamic> json) =>
      ViewState<bool>.fromJson(
        json,
        (raw) => raw as bool,
      );
}
