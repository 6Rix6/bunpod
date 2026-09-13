import 'dart:async';

import 'package:bunpod/bunpod.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CategoryIdsCubit extends IntListViewCubit {
  CategoryIdsCubit(this._repository);
  final CategoryRepository _repository;

  @override
  Stream<List<int>> watchStream() => _repository.watchCategories();
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
    if (state.isBusy || isClosed) return;
    emit(state.copyWithPrevious(const ViewBusy()));

    final nextState = await ViewState.guard(
      _repository.getExploreCategory(_id),
    );

    if (!isClosed) {
      emit(state.copyWithPrevious(nextState));
    }
  }

  @override
  String get id => '$runtimeType $_id';

  @override
  Map<String, dynamic>? toJson(ViewState<ExploreCategory> state) =>
      state.toJson((value) => value.toJson());

  @override
  ViewState<ExploreCategory>? fromJson(Map<String, dynamic> json) =>
      ViewState<ExploreCategory>.fromJsonSafe(
        json,
        (raw) => ExploreCategory.fromJson(raw as Map<String, dynamic>),
      );
}
