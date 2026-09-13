import 'dart:async';

import 'package:bunpod/bunpod.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class HostIdsCubit extends IntListViewCubit {
  HostIdsCubit(this._repository);
  final HostsRepository _repository;

  @override
  Stream<List<int>> watchStream() => _repository.watchHosts();
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
    if (state.isBusy || isClosed) return;
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
      ViewState<ExploreHost>.fromJsonSafe(
        json,
        (raw) => ExploreHost.fromJson(raw as Map<String, dynamic>),
      );
}
