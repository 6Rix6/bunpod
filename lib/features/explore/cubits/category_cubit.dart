import 'dart:async';

import 'package:bunpod/bunpod.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CategoryIdsCubit extends HydratedCubit<ViewState<List<int>>> {
  CategoryIdsCubit(this._repository) : super(const ViewIdle()) {
    _subscribeToStream();
  }

  final CategoryRepository _repository;
  StreamSubscription<List<int>>? _subscription;

  void _subscribeToStream() {
    _subscription = _repository.watchCategories().listen(
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

class ExploreCategoryCubit extends HydratedCubit<ViewState<ExploreCategory>> {
  ExploreCategoryCubit(this._repository, {required int categoryId})
    : _id = categoryId,
      super(const ViewIdle()) {
    refresh();
  }

  final CategoryRepository _repository;
  final int _id;

  Future<void> refresh() async {
    if (state.isBusy) return;
    emit(state.copyWithPrevious(const ViewBusy()));

    final nextState = await ViewState.guard(
      _repository.getExploreCategory(_id),
    );

    if (!isClosed) {
      emit(state.copyWithPrevious(nextState));
    }
  }

  @override
  String get id => _id.toString();

  @override
  Map<String, dynamic>? toJson(ViewState<ExploreCategory> state) =>
      state.toJson((value) => value.toJson());

  @override
  ViewState<ExploreCategory>? fromJson(Map<String, dynamic> json) =>
      ViewState<ExploreCategory>.fromJson(
        json,
        (raw) => ExploreCategory.fromJson(raw as Map<String, dynamic>),
      );
}
