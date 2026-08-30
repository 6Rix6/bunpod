import 'package:bunpod/bunpod.dart';

extension ViewStateX<T> on ViewState<T> {
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
