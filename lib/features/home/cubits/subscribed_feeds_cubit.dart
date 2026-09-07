import 'package:bunpod/bunpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SubscribedFeedsCubit extends HydratedCubit<ViewState<List<PodcastFeed>>> {
  SubscribedFeedsCubit(this._feedRepository, this._channelsRepository)
    : super(const ViewIdle()) {
    refresh();
  }

  final PodcastFeedRepository _feedRepository;
  final SubscribedChannelsRepository _channelsRepository;

  Future<void> refresh({void Function(Object error)? onError}) async {
    if (state.isBusy) return;

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

  @override
  Map<String, dynamic>? toJson(ViewState<List<PodcastFeed>> state) =>
      state.toJson((list) => list.map((e) => e.toJson()).toList());

  @override
  ViewState<List<PodcastFeed>>? fromJson(Map<String, dynamic> json) =>
      ViewState<List<PodcastFeed>>.fromJson(
        json,
        (raw) => (raw as List)
            .map((e) => PodcastFeed.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
