import 'package:background_downloader/background_downloader.dart';

enum DownloadState {
  idle,
  enqueued,
  running,
  paused,
  waitingToRetry,
  completed,
  failed,
  canceled,
  notFound;

  const DownloadState();

  static DownloadState fromTaskStatus(TaskStatus status) {
    return switch (status) {
      TaskStatus.enqueued => DownloadState.enqueued,
      TaskStatus.running => DownloadState.running,
      TaskStatus.paused => DownloadState.paused,
      TaskStatus.waitingToRetry => DownloadState.waitingToRetry,
      TaskStatus.complete => DownloadState.completed,
      TaskStatus.canceled => DownloadState.canceled,
      TaskStatus.notFound => DownloadState.notFound,
      TaskStatus.failed => DownloadState.failed,
    };
  }

  bool get isInProgress => switch (this) {
    .enqueued || .running || .paused => true,
    _ => false,
  };

  bool get isFinished => switch (this) {
    .completed || .canceled || .notFound || .failed => true,
    _ => false,
  };

  bool get isSuccessful => this == .completed;

  bool get isUnsuccessful => isFinished && !isSuccessful;
}

class DownloadProgressInfo {
  const DownloadProgressInfo({
    required this.state,
    this.progress = 0.0,
    this.hasExpectedFileSize = false,
    this.expectedFileSize = -1,
    this.hasNetworkSpeed = false,
    this.networkSpeed = -1.0,
    this.hasTimeRemaining = false,
    this.timeRemaining = Duration.zero,
    this.errorMessage,
    this.filePath,
  });

  final DownloadState state;

  /// 0.0〜1.0. Can be a negative value if unknown.
  final double progress;

  final bool hasExpectedFileSize;
  final int expectedFileSize;

  final bool hasNetworkSpeed;

  /// MB/s
  final double networkSpeed;

  final bool hasTimeRemaining;
  final Duration timeRemaining;

  /// Error message on failure
  final String? errorMessage;

  final String? filePath;

  factory DownloadProgressInfo.initial() =>
      const DownloadProgressInfo(state: DownloadState.idle);

  factory DownloadProgressInfo.fromProgressUpdate(TaskProgressUpdate update) {
    return DownloadProgressInfo(
      state: DownloadState.running,
      progress: update.progress,
      hasExpectedFileSize: update.hasExpectedFileSize,
      expectedFileSize: update.expectedFileSize,
      hasNetworkSpeed: update.hasNetworkSpeed,
      networkSpeed: update.networkSpeed,
      hasTimeRemaining: update.hasTimeRemaining,
      timeRemaining: update.timeRemaining,
    );
  }

  factory DownloadProgressInfo.fromStatusUpdate(
    TaskStatusUpdate update,
    String? filePath, [
    double? lastProgress,
  ]) {
    final state = DownloadState.fromTaskStatus(update.status);
    return DownloadProgressInfo(
      state: state,
      progress: lastProgress ?? (state == DownloadState.completed ? 1.0 : 0.0),
      errorMessage: update.exception?.description,
      filePath: state == DownloadState.completed ? filePath : null,
    );
  }

  factory DownloadProgressInfo.fromTaskRecord(
    TaskRecord record,
    String filePath,
  ) {
    final state = DownloadState.fromTaskStatus(record.status);
    return DownloadProgressInfo(
      state: state,
      progress: state == DownloadState.completed ? 1.0 : record.progress,
      hasExpectedFileSize: record.expectedFileSize > 0,
      expectedFileSize: record.expectedFileSize,
      errorMessage: record.exception?.description,
      filePath: filePath,
    );
  }

  bool get isInProgress => state.isInProgress;

  bool get isFinished => state.isFinished;

  DownloadProgressInfo copyWith({
    DownloadState? state,
    double? progress,
    bool? hasExpectedFileSize,
    int? expectedFileSize,
    bool? hasNetworkSpeed,
    double? networkSpeed,
    bool? hasTimeRemaining,
    Duration? timeRemaining,
    String? errorMessage,
    String? filePath,
  }) {
    return DownloadProgressInfo(
      state: state ?? this.state,
      progress: progress ?? this.progress,
      hasExpectedFileSize: hasExpectedFileSize ?? this.hasExpectedFileSize,
      expectedFileSize: expectedFileSize ?? this.expectedFileSize,
      hasNetworkSpeed: hasNetworkSpeed ?? this.hasNetworkSpeed,
      networkSpeed: networkSpeed ?? this.networkSpeed,
      hasTimeRemaining: hasTimeRemaining ?? this.hasTimeRemaining,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      errorMessage: errorMessage ?? this.errorMessage,
      filePath: filePath ?? this.filePath,
    );
  }

  @override
  String toString() =>
      'DownloadProgressInfo(state: $state, progress: $progress)';
}
