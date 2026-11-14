import 'dart:async';

import 'package:background_downloader/background_downloader.dart';
import 'package:bunpod/bunpod.dart';

typedef DownloadTaskWithState = ({DownloadTask data, DownloadState state});

/// A class that holds a single app-wide [FileDownloader] instance and
/// manages starting downloads, monitoring progress, and cancelling
/// downloads, keyed by URL.
///
/// [FileDownloader().updates] is a single-subscription stream, so only
/// this class may subscribe to it within the app.
/// It re-broadcasts the data as a broadcast Stream for external consumers
/// (e.g. Cubits) to use.
class DownloadManager {
  final FileDownloader _fileDownloader = FileDownloader();

  bool _initialized = false;

  // url -> the task dedicated to that URL
  final Map<String, DownloadTaskWithState> _allTasks = {};

  /// urls of the currently active DownloadTask
  final Set<String> _activeTasks = {};

  /// url -> the most recent download state (used as the initial value
  /// when a Cubit is created)
  final Map<String, DownloadProgressInfo> _lastProgress = {};

  final StreamController<List<DownloadTaskWithState>> _allTasksController =
      StreamController<List<DownloadTaskWithState>>.broadcast();

  /// Stream that emits the list of URLs currently downloading
  /// (enqueued/running/paused)
  final StreamController<List<String>> _activeUrlsController =
      StreamController<List<String>>.broadcast();

  /// url -> the progress Stream dedicated to that URL
  final Map<String, StreamController<DownloadProgressInfo>>
  _progressControllers = {};

  StreamSubscription<TaskUpdate>? _updatesSubscription;

  List<DownloadTaskWithState> get allTasks =>
      List<DownloadTaskWithState>.unmodifiable(_allTasks.values);

  Stream<List<DownloadTaskWithState>> get allTasksStream =>
      _allTasksController.stream;

  /// List of URLs currently downloading (enqueued/running/paused/waitingToRetry)
  List<String> get activeUrls => List.unmodifiable(_activeTasks);

  /// Stream of the "list of downloading URLs". Subscribed to by
  /// ActiveDownloadsCubit.
  Stream<List<String>> get activeUrlsStream => _activeUrlsController.stream;

  /// Call once when the app starts. Enables DB tracking and starts
  /// listening for events.
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    _updatesSubscription = _fileDownloader.updates.listen(_handleUpdate);

    _fileDownloader.configure(
      androidConfig: (Config.runInForeground, Config.always),
    );

    await configureNotification();

    final List<TaskRecord> records = [];

    try {
      records.addAll(await _fileDownloader.database.allRecords());
    } catch (e) {
      logarte.log('Failed to read FileDownloader database. error: $e');
    }

    final futures = records.map((record) async {
      final task = record.task;
      if (task is! DownloadTask) return;

      try {
        final filePath = await task.filePath();
        final info = DownloadProgressInfo.fromTaskRecord(record, filePath);

        final TaskStatus status = record.status;

        _setToAllTask(task.url, task, status);

        if (status.isNotFinalState) {
          _setActiveTask(task.url);
        }

        _lastProgress[task.url] = info;
        _progressControllerFor(task.url).add(info);
      } catch (e, st) {
        logarte.log(
          'failed to convert TaskRecord into DownloadProgressInfo.\n task: $task, $e: $st',
        );
        return;
      }
    });

    await Future.wait(futures);

    // Enable database task tracking, resuming after a forced app
    // termination, etc.
    await _fileDownloader.start(doTrackTasks: true, autoCleanDatabase: false);
  }

  /// Configures the notification for download progress if the permission granted.
  Future<void> configureNotification() async {
    final PermissionStatus notificationStatus = await _fileDownloader
        .permissions
        .status(
          .notifications,
        );

    if (notificationStatus == .granted) {
      _fileDownloader.configureNotificationForGroup(
        FileDownloader.defaultGroup,
        running: const TaskNotification(
          'Downloading {displayName}',
          '{progress}',
        ),
        progressBar: true,
      );
    }
  }

  /// Progress Stream for the given URL. Subscribed to by
  /// DownloadProgressCubit.
  /// If you always want the latest state at creation time to be emitted
  /// first, combine this with [lastProgressOf] for the Cubit's initial
  /// state.
  Stream<DownloadProgressInfo> progressStreamOf(String url) {
    return _progressControllerFor(url).stream;
  }

  /// Snapshot of the most recent state for the given URL (idle if not
  /// yet retrieved).
  DownloadProgressInfo lastProgressOf(String url) =>
      _lastProgress[url] ?? DownloadProgressInfo.initial();

  /// Starts a download.
  ///
  /// If the same URL is already downloading, does nothing (prevents
  /// duplicate downloads).
  Future<void> download(
    String url, {
    String? filename,
    String directory = '',
    BaseDirectory baseDirectory = BaseDirectory.applicationDocuments,
    Map<String, String>? headers,
    bool requiresWiFi = false,
    bool allowPause = true,
    String metaDada = '',
    String displayName = '',
  }) async {
    if (_activeTasks.contains(url)) {
      return; // Already in progress
    }

    final task = DownloadTask(
      url: url,
      filename: filename ?? DownloadTask.suggestedFilename,
      directory: directory,
      baseDirectory: baseDirectory,
      headers: headers ?? const {},
      requiresWiFi: requiresWiFi,
      allowPause: allowPause,
      updates: Updates.statusAndProgress,
      metaData: metaDada,
      displayName: displayName,
      priority: 0,
    );

    _setToAllTask(url, task, TaskStatus.enqueued);
    _setActiveTask(url);
    _updateProgress(url, DownloadProgressInfo(state: DownloadState.enqueued));

    final enqueued = await _fileDownloader.enqueue(task);
    if (!enqueued) {
      // If enqueue itself fails, treat it as finished here.
      _updateProgress(
        url,
        const DownloadProgressInfo(
          state: DownloadState.failed,
          errorMessage: 'Failed to enqueue the task.',
        ),
      );
      _removeActiveTask(url);
    }
  }

  Future<void> cancel(String url) async {
    final task = _allTasks[url];
    if (task == null) return;

    await _fileDownloader.cancelTaskWithId(task.data.taskId);
  }

  Future<void> pause(String url) async {
    final task = _allTasks[url];
    if (task == null) return;

    await _fileDownloader.pause(task.data);
  }

  Future<void> resume(String url) async {
    final task = _allTasks[url];
    if (task == null) return;

    final canResume = await _fileDownloader.taskCanResume(task.data);
    if (!canResume) return;

    await _fileDownloader.resume(task.data);
  }

  Future<void> retry(String url) async {
    final task = _allTasks[url];
    if (task == null) return;

    await _fileDownloader.enqueue(task.data);
  }

  Future<void> deleteTask(String url) async {
    final task = _allTasks[url];
    if (task == null) return;

    _removeActiveTask(url);
    _removeFromAllTask(url);
    await _fileDownloader.database.deleteRecordWithId(task.data.taskId);
  }

  void _handleUpdate(TaskUpdate update) {
    final task = update.task;
    final url = task.url;

    if (task is! DownloadTask) return;

    switch (update) {
      case TaskStatusUpdate():
        _handleStatusUpdate(url, task, update);
      case TaskProgressUpdate():
        // Final states like pause/cancel/complete are managed via
        // StatusUpdate, so ProgressUpdate only reflects progress while
        // running.
        if (_activeTasks.contains(url)) {
          _updateProgress(url, DownloadProgressInfo.fromProgressUpdate(update));
        }
    }
  }

  Future<void> _handleStatusUpdate(
    String url,
    DownloadTask task,
    TaskStatusUpdate update,
  ) async {
    _setToAllTask(url, task, update.status);

    switch (update.status) {
      case TaskStatus.enqueued:
      case TaskStatus.running:
        _setActiveTask(url);
        _updateProgress(
          url,
          DownloadProgressInfo.fromStatusUpdate(update, null),
        );
      case TaskStatus.paused:
        // Keep the task retained while paused too, for
        // retry/resume operations.
        _updateProgress(
          url,
          DownloadProgressInfo.fromStatusUpdate(
            update,
            null,
            _lastProgress[url]?.progress,
          ),
        );
      case TaskStatus.complete:
        String? path;
        try {
          path = await task.filePath();
        } catch (e, st) {
          logarte.log('[DownloadManager] filePath() failed for $url: $e\n$st');
        }
        _updateProgress(
          url,
          DownloadProgressInfo.fromStatusUpdate(update, path),
        );
        _removeActiveTask(url);
      case TaskStatus.canceled:
      case TaskStatus.failed:
      case TaskStatus.notFound:
        _updateProgress(
          url,
          DownloadProgressInfo.fromStatusUpdate(update, null),
        );
        _removeActiveTask(url);
      case TaskStatus.waitingToRetry:
        // Treat waiting-to-retry as "in progress" as well.
        _setActiveTask(url);
        _updateProgress(
          url,
          DownloadProgressInfo.fromStatusUpdate(update, null),
        );
    }
  }

  void _setToAllTask(String url, DownloadTask task, TaskStatus status) {
    _allTasks[url] = (data: task, state: DownloadState.fromTaskStatus(status));
    _allTasksController.add(allTasks);
  }

  void _removeFromAllTask(String url) {
    _allTasks.remove(url);
    _allTasksController.add(allTasks);

    _updateProgress(url, .initial());
  }

  void _setActiveTask(String url) {
    if (_activeTasks.add(url)) {
      _activeUrlsController.add(activeUrls);
    }
  }

  void _removeActiveTask(String url) {
    if (_activeTasks.remove(url)) {
      _activeUrlsController.add(activeUrls);
    }
  }

  void _updateProgress(String url, DownloadProgressInfo info) {
    _lastProgress[url] = info;
    _progressControllerFor(url).add(info);
  }

  StreamController<DownloadProgressInfo> _progressControllerFor(String url) {
    return _progressControllers.putIfAbsent(
      url,
      () => StreamController<DownloadProgressInfo>.broadcast(),
    );
  }

  /// Cleanup to call when the app is terminating, etc.
  Future<void> dispose() async {
    await _allTasksController.close();
    await _activeUrlsController.close();
    for (final controller in _progressControllers.values) {
      await controller.close();
    }
    _progressControllers.clear();
    _updatesSubscription?.cancel();
  }
}
