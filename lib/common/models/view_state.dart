import 'package:bunpod/bunpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_state.freezed.dart';
part 'view_state.g.dart';

typedef ViewStateError = AppError;

@Freezed(genericArgumentFactories: true)
sealed class ViewState<T> with _$ViewState<T> {
  const ViewState._();

  const factory ViewState.idle() = ViewIdle<T>;

  const factory ViewState.busy([T? data]) = ViewBusy<T>;

  const factory ViewState.ready(T data) = ViewReady<T>;

  const factory ViewState.failed([
    AppError? error,
    T? previousData,
  ]) = ViewFailed<T>;

  factory ViewState.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ViewStateFromJson(json, fromJsonT);

  // Copyright: aljan.me
  static Future<ViewState<T>> guard<T>(
    TaskEither<ViewStateError, T> task, {
    ViewState<T> Function(T result)? onSuccess,
    void Function(ViewStateError error)? onError,
  }) {
    return task.match(
      (error) {
        onError?.call(error);
        logarte.log('error: $error');
        return ViewFailed<T>(error);
      },
      (result) => onSuccess?.call(result) ?? ViewReady<T>(result),
    ).run();
  }

  ViewState<T> copyWithPrevious(
    ViewState<T> next,
  ) {
    final currentData = dataOrNull;

    return switch (next) {
      // Carry over previous data during background reload
      ViewBusy() when currentData != null => ViewBusy<T>(currentData),
      // Retain previous data even if subsequent fetch fails
      ViewFailed(:final error) when currentData != null => ViewFailed<T>(
        error,
        currentData,
      ),
      _ => next,
    };
  }

  bool get isIdle => this is ViewIdle<T>;
  bool get isBusy => this is ViewBusy<T>;
  bool get isReady => this is ViewReady<T>;
  bool get isFailed => this is ViewFailed<T>;

  T get requireData => (this as ViewReady<T>).data!;

  T? get dataOrNull => switch (this) {
    ViewReady(:final data) => data,
    ViewBusy(:final data) => data,
    ViewFailed(:final previousData) => previousData,
    _ => null,
  };

  ViewStateError? get errorOrNull => switch (this) {
    ViewFailed(:final error) => error,
    _ => null,
  };
}
