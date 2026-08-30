import 'package:bunpod/bunpod.dart';
import 'package:fpdart/fpdart.dart';

typedef ViewStateError = AppError;

sealed class ViewState<T> {
  const ViewState();

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
}

final class ViewIdle<T> extends ViewState<T> {
  const ViewIdle();
}

final class ViewBusy<T> extends ViewState<T> {
  final T? data;

  const ViewBusy([this.data]);
}

final class ViewReady<T> extends ViewState<T> {
  final T data;

  const ViewReady(this.data);
}

final class ViewFailed<T> extends ViewState<T> {
  final ViewStateError? error;
  final T? previousData;

  const ViewFailed([this.error, this.previousData]);
}
