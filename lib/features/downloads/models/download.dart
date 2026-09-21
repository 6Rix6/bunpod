import 'package:bunpod/bunpod.dart';

/// One episode stored on (or on its way to) the device.
class Download {
  const Download({
    required this.episode,
    required this.megabytes,
    this.state = .completed,
    this.received = 0,
  });

  final Episode episode;
  final int megabytes;
  final DownloadState state;

  /// Megabytes fetched so far — only meaningful while [state] is downloading.
  final int received;

  double get progress => megabytes == 0 ? 0 : received / megabytes;

  bool get played => false;
}

/// Compact file-size label, e.g. `284 MB`, `1.2 GB`.
String sizeLabel(int megabytes) {
  if (megabytes >= 1000) {
    final String gb = (megabytes / 1000)
        .toStringAsFixed(1)
        .replaceAll('.0', '');

    return '$gb GB';
  }

  return '$megabytes MB';
}
