import 'package:bunpod/bunpod.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class PodcastFeedCubit extends Cubit<ViewState<PodcastFeed>> {
  PodcastFeedCubit(this._repository, {required this.url})
    : super(const ViewIdle()) {
    fetch();
  }

  final PodcastFeedRepository _repository;
  final String url;

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

  TaskEither<AppError, PodcastFeed> get _fetchFeeds {
    return TaskEither<AppError, PodcastFeed>.tryCatch(
      () => _repository
          .fetchFeeds([url])
          .then(
            (e) => e.fold((l) => throw l, (r) => r.first),
          ),
      (error, _) =>
          error is AppError ? error : UnknownError(error, StackTrace.current),
    );
  }
}
