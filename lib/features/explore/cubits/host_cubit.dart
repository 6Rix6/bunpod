import 'dart:async';

import 'package:bunpod/bunpod.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class HostIdsCubit extends HydratedCubit<ViewState<List<int>>> {
  HostIdsCubit(this._repository) : super(const ViewIdle()) {
    _subscribeToStream();
  }

  final HostsRepository _repository;
  StreamSubscription<List<int>>? _subscription;

  void _subscribeToStream() {
    _subscription = _repository.watchHosts().listen(
      (categories) => emit(ViewReady(categories)),
      onError: (e) =>
          emit(state.copyWithPrevious(ViewFailed(CacheError(e.toString())))),
    );
  }

  @override
  Map<String, dynamic>? toJson(ViewState<List<int>> state) =>
      state.toJson((list) => list);

  @override
  ViewState<List<int>>? fromJson(Map<String, dynamic> json) =>
      ViewState<List<int>>.fromJson(json, (raw) => raw as List<int>);

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

class ExploreHostCubit extends HydratedCubit<ViewState<ExploreHost>> {
  ExploreHostCubit(this._repository, {required int hostId})
    : _id = hostId,
      super(const ViewIdle()) {
    refresh();
  }

  final HostsRepository _repository;
  final int _id;

  Future<void> refresh() async {
    if (state.isBusy) return;
    emit(state.copyWithPrevious(const ViewBusy()));

    final nextState = await ViewState.guard(
      _repository.getExploreHost(_id),
    );

    if (!isClosed) {
      emit(state.copyWithPrevious(nextState));
    }
  }

  @override
  String get id => _id.toString();

  @override
  Map<String, dynamic>? toJson(ViewState<ExploreHost> state) =>
      state.toJson((value) => value.toJson());

  @override
  ViewState<ExploreHost>? fromJson(Map<String, dynamic> json) =>
      ViewState<ExploreHost>.fromJson(
        json,
        (raw) => ExploreHost.fromJson(raw as Map<String, dynamic>),
      );
}
