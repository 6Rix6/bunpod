import 'package:bunpod/bunpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

const _debugUrls = [
  'https://www.omnycontent.com/d/playlist/67122501-9b17-4d77-84bd-a93d00dc791e/3551f0c9-79eb-4ca9-9e0e-b38700916820/8742367b-b8c0-414a-91d9-b3c9006daddd/podcast.rss',
  'https://feeds.megaphone.fm/TAC9650125234',
  'https://anchor.fm/s/1035e1308/podcast/rss',
];

class SubscribedFeedsCubit extends HydratedCubit<ViewState<List<PodcastFeed>>> {
  SubscribedFeedsCubit(this._repository) : super(const ViewIdle()) {
    refresh();
  }

  final PodcastFeedRepository _repository;

  Future<void> fetch() async {
    if (state.isBusy) return;

    emit(const ViewBusy());

    final nextState = await ViewState.guard(_fetchFeeds);

    if (!isClosed) {
      emit(nextState);
    }
  }

  Future<void> refresh({void Function(Object error)? onError}) async {
    if (state.isBusy) return;

    final previousState = state;
    emit(previousState.copyWithPrevious(const ViewBusy()));

    final nextState = await ViewState.guard(
      _fetchFeeds,
      onError: onError,
    );

    if (!isClosed) {
      emit(previousState.copyWithPrevious(nextState));
    }
  }

  TaskEither<AppError, List<PodcastFeed>> get _fetchFeeds {
    return TaskEither<AppError, List<PodcastFeed>>.tryCatch(
      () => _repository
          .fetchFeeds(_debugUrls)
          .then(
            (e) => e.fold((l) => throw l, (r) => r),
          ),
      (error, _) =>
          error is AppError ? error : UnknownError(error, StackTrace.current),
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
