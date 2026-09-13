import 'dart:async';

import 'package:bunpod/bunpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SubscribedFeedsCubit extends HydratedCubit<ViewState<List<PodcastFeed>>> {
  SubscribedFeedsCubit(this._feedRepository, this._channelsRepository)
    : super(const ViewIdle()) {
    refresh();
    _subscribeToStream();
  }

  final PodcastFeedRepository _feedRepository;
  final SubscribedChannelsRepository _channelsRepository;

  StreamSubscription<List<int>>? _subscription;

  Future<void> refresh({void Function(Object error)? onError}) async {
    if (state.isBusy || isClosed) return;

    final previousState = state;
    emit(previousState.copyWithPrevious(const ViewBusy()));

    final task = _channelsRepository.getFeedUrls().flatMap(
      (urls) => _fetchFeedTask(urls),
    );

    final nextState = await ViewState.guard(
      task,
      onError: onError,
    );

    if (!isClosed) {
      emit(previousState.copyWithPrevious(nextState));
    }
  }

  AppTaskEither<List<PodcastFeed>> _fetchFeedTask(List<String> urls) {
    return TaskEither<AppError, List<PodcastFeed>>.tryCatch(
      () async {
        final result = await _feedRepository.fetchFeeds(urls);
        return result.fold((l) => throw l, (r) => r);
      },
      (error, stackTrace) =>
          error is AppError ? error : UnknownError(error, stackTrace),
    );
  }

  void _subscribeToStream() {
    _subscription = _channelsRepository
        .watchSubscribedChannelIds()
        .throttleTime(const Duration(seconds: 5))
        .listen(
          (data) => refresh(),
        );
  }

  @override
  Map<String, dynamic>? toJson(ViewState<List<PodcastFeed>> state) =>
      state.toJson((list) => list.map((e) => e.toJson()).toList());

  @override
  ViewState<List<PodcastFeed>>? fromJson(Map<String, dynamic> json) =>
      ViewState<List<PodcastFeed>>.fromJsonSafe(
        json,
        (raw) => (raw as List)
            .map((e) => PodcastFeed.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
