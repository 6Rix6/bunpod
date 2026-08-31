import 'package:bunpod/bunpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

const _debugUrls = [
  'https://www.omnycontent.com/d/playlist/67122501-9b17-4d77-84bd-a93d00dc791e/3551f0c9-79eb-4ca9-9e0e-b38700916820/8742367b-b8c0-414a-91d9-b3c9006daddd/podcast.rss',
  'https://feeds.megaphone.fm/TAC9650125234',
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
      () => _repository.fetchFeeds(_debugUrls).then(
        (e) => e.fold((l) => throw l, (r) => r),
      ),
      (error, _) =>
          error is AppError ? error : UnknownError(error, StackTrace.current),
    );
  }

  @override
  Map<String, dynamic>? toJson(ViewState<List<PodcastFeed>> state) =>
      state.toJson();

  @override
  ViewState<List<PodcastFeed>>? fromJson(Map<String, dynamic> json) =>
      _ViewStateSerialize.fromJson(json);
}

extension _ViewStateSerialize on ViewState<List<PodcastFeed>> {
  Map<String, dynamic> toJson() {
    return switch (this) {
      ViewIdle() => {
        'type': 'idle',
      },
      ViewBusy(:final data) => {
        'type': 'busy',
        'data': data?.map((e) => e.toJson()).toList(),
      },
      ViewReady(:final data) => {
        'type': 'ready',
        'data': data.map((e) => e.toJson()).toList(),
      },
      ViewFailed(:final error, :final previousData) => {
        'type': 'failed',
        'error': error?.toJson(),
        'previousData': previousData?.map((e) => e.toJson()).toList(),
      },
    };
  }

  static ViewState<List<PodcastFeed>> fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;

    List<PodcastFeed>? decodeList(dynamic raw) {
      if (raw == null) return null;
      return (raw as List)
          .map((e) => PodcastFeed.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return switch (type) {
      'busy' => ViewBusy<List<PodcastFeed>>(decodeList(json['data'])),
      'ready' => ViewReady<List<PodcastFeed>>(
        decodeList(json['data']) ?? const <PodcastFeed>[],
      ),
      'failed' => ViewFailed<List<PodcastFeed>>(
        json['error'] != null
            ? AppError.fromJson(json['error'] as Map<String, dynamic>)
            : null,
        decodeList(json['previousData']),
      ),
      _ => const ViewIdle<List<PodcastFeed>>(),
    };
  }
}
