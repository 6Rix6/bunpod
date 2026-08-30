import 'package:bunpod/bunpod.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class PodcastFeedsCubit extends Cubit<ViewState<List<PodcastFeed>>> {
  PodcastFeedsCubit(this._repository) : super(const ViewIdle()) {
    fetch();
  }

  final PodcastFeedRepository _repository;

  Future<void> fetch() async {
    if (state.isBusy) return;

    emit(const ViewBusy());

    final nextState = await ViewState.guard(_fetchFeeds);

    emit(nextState);
  }

  Future<void> refresh({void Function(Object error)? onError}) async {
    if (state.isBusy) return;

    final previousState = state;
    emit(previousState.copyWithPrevious(const ViewBusy()));

    final nextState = await ViewState.guard(
      _fetchFeeds,
      onError: onError,
    );

    emit(previousState.copyWithPrevious(nextState));
  }

  TaskEither<AppError, List<PodcastFeed>> get _fetchFeeds {
    return TaskEither<AppError, List<PodcastFeed>>.tryCatch(
      () => _repository.fetchFeeds().then(
        (e) => e.fold((l) => throw l, (r) => r),
      ),
      (error, _) =>
          error is AppError ? error : UnknownError(error, StackTrace.current),
    );
  }
}
