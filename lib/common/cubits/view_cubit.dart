import 'dart:async';

import 'package:bunpod/bunpod.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rxdart/rxdart.dart';

abstract class ViewCubit<T> extends HydratedCubit<ViewState<T>> {
  ViewCubit() : super(ViewIdle<T>());

  Object? toJsonT(T data);
  T fromJsonT(Object? json);

  @override
  Map<String, dynamic>? toJson(ViewState<T> state) => state.toJson(toJsonT);

  @override
  ViewState<T>? fromJson(Map<String, dynamic> json) =>
      ViewState<T>.fromJsonSafe(json, fromJsonT);
}

abstract class StreamViewCubit<T> extends ViewCubit<T> {
  StreamViewCubit() {
    _subscription = watchStream()
        .throttleTime(throttleTime)
        .listen(
          (data) => emit(ViewReady(data)),
          onError: (e) => emit(
            state.copyWithPrevious(ViewFailed(CacheError(e.toString()))),
          ),
        );
  }

  Duration get throttleTime => Duration.zero;

  StreamSubscription<T>? _subscription;

  Stream<T> watchStream();

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

abstract class IntListViewCubit extends StreamViewCubit<List<int>> {
  @override
  List<int> toJsonT(List<int> data) => data;

  @override
  List<int> fromJsonT(Object? json) => (json as List).cast<int>();
}
