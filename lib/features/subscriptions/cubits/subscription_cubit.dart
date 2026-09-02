import 'dart:async';
import 'package:bunpod/bunpod.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SubscriptionCubit extends HydratedCubit<ViewState<bool>> {
  SubscriptionCubit(
    this.repository, {
    required this.feedUrl,
  }) : super(const ViewIdle()) {
    _subscribeToStream();
  }

  final SubscriptionRepository repository;
  final String feedUrl;
  StreamSubscription<bool>? _subscription;

  @override
  String get id => feedUrl;

  void _subscribeToStream() {
    _subscription = repository
        .watchIsSubscribed(feedUrl)
        .listen(
          (isSubscribed) => emit(ViewReady(isSubscribed)),
          onError: (Object e) => emit(
            state.copyWithPrevious(ViewFailed(CacheError(e.toString()))),
          ),
        );
  }

  Future<void> subscribe() async {
    try {
      await repository.subscribe(feedUrl);
    } catch (e) {
      emit(state.copyWithPrevious(ViewFailed(AppError.cache(e.toString()))));
    }
  }

  Future<void> unsubscribe() async {
    try {
      await repository.unsubscribe(feedUrl);
    } catch (e) {
      emit(state.copyWithPrevious(ViewFailed(AppError.cache(e.toString()))));
    }
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
