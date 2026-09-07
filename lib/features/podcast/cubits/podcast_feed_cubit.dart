import 'package:bunpod/bunpod.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PodcastFeedCubit extends HydratedCubit<ViewState<PodcastFeed>> {
  PodcastFeedCubit(this._repository, {required this.url})
    : super(const ViewIdle()) {
    refresh();
  }

  @override
  String get id => url;

  final PodcastFeedRepository _repository;
  final String url;

  Future<void> refresh({void Function(Object error)? onError}) async {
    if (state.isBusy || isClosed) return;

    final previousState = state;
    emit(previousState.copyWithPrevious(const ViewBusy()));

    final nextState = await ViewState.guard(
      _repository.fetchFeed(url),
      onError: onError,
    );

    if (!isClosed) {
      emit(previousState.copyWithPrevious(nextState));
    }
  }

  @override
  Map<String, dynamic>? toJson(ViewState<PodcastFeed> state) =>
      state.toJson((f) => f.toJson());

  @override
  ViewState<PodcastFeed>? fromJson(Map<String, dynamic> json) =>
      ViewState<PodcastFeed>.fromJson(
        json,
        (raw) => PodcastFeed.fromJson(raw as Map<String, dynamic>),
      );
}
