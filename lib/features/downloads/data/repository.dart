import 'dart:convert';
import 'dart:io';

import 'package:bunpod/bunpod.dart';
import 'package:xxh3/xxh3.dart';

typedef IdWithState = ({int id, DownloadState state});

abstract interface class DownloadRepository {
  List<IdWithState> getEpisodeIdsWithState();
  Stream<List<IdWithState>> episodeIdsWithStateStream();

  DownloadProgressInfo getLastProgressOf(String url);
  Stream<DownloadProgressInfo> progressStreamOf(String url);

  Future<void> download(Episode episode);
  Future<void> pause(String url);
  Future<void> resume(String url);
  Future<void> cancel(String url);
  Future<void> retry(String url);

  Future<File?> downloadedFor(Episode episode);
  AppTaskEither<void> deleteDownloadedFor(Episode episode, [bool deleteTask]);
  AppTaskEither<void> deleteDownloadTaskFor(String url);
}

class DownloadRepositoryImpl implements DownloadRepository {
  DownloadRepositoryImpl(this._manager);
  final DownloadManager _manager;

  static const String downloadDirectory = 'episodes';

  List<IdWithState> _mapTasks(List<DownloadTaskWithState> tasks) {
    return tasks
        .map((task) {
          final (:data, :state) = task;
          final id = int.tryParse(data.metaData);
          if (id == null) return null;

          return (id: id, state: state);
        })
        .whereType<IdWithState>()
        .toList();
  }

  @override
  List<IdWithState> getEpisodeIdsWithState() => _mapTasks(_manager.allTasks);

  @override
  Stream<List<IdWithState>> episodeIdsWithStateStream() =>
      _manager.allTasksStream.map(_mapTasks);

  @override
  DownloadProgressInfo getLastProgressOf(String url) =>
      _manager.lastProgressOf(url);

  @override
  Stream<DownloadProgressInfo> progressStreamOf(String url) =>
      _manager.progressStreamOf(url);

  @override
  Future<void> download(Episode episode) async {
    if ((await downloadedFor(episode)) != null) {
      return;
    }

    final url = episode.audioUrl;

    final fileName = _generateFileName(url);
    return _manager.download(
      url,
      filename: fileName,
      directory: downloadDirectory,
      metaDada: episode.localId.toString(),
    );
  }

  @override
  Future<void> pause(String url) => _manager.pause(url);

  @override
  Future<void> resume(String url) => _manager.resume(url);

  @override
  Future<void> cancel(String url) => _manager.cancel(url);

  @override
  Future<void> retry(String url) => _manager.retry(url);

  @override
  Future<File?> downloadedFor(Episode episode) async {
    final info = _manager.lastProgressOf(episode.audioUrl);

    if (info.state != .completed || info.filePath == null) {
      return null;
    }

    final file = File(info.filePath!);
    return await file.exists() ? file : null;
  }

  @override
  AppTaskEither<void> deleteDownloadedFor(
    Episode episode, [
    bool deleteTask = true,
  ]) {
    return AppTaskEither.tryCatch(
      () async {
        final file = await downloadedFor(episode);
        if (file == null) return;

        await file.delete();
      },
      (error, stackTrace) => CacheError(error.toString()),
    ).flatMap((_) {
      if (deleteTask) {
        return deleteDownloadTaskFor(episode.audioUrl);
      } else {
        return AppTaskEither.right(null);
      }
    });
  }

  @override
  AppTaskEither<void> deleteDownloadTaskFor(String url) {
    return AppTaskEither.tryCatch(
      () async {
        await _manager.deleteTask(url);
      },
      (error, stackTrace) => CacheError(error.toString()),
    );
  }

  String _generateFileName(String url) {
    final fileName = _extractFileName(url);

    final bytes = utf8.encode(url);
    final hash = xxh3String(bytes);

    return '$hash-$fileName';
  }

  String _extractFileName(String url) {
    var segment = Uri.parse(url).pathSegments.isNotEmpty
        ? Uri.parse(url).pathSegments.last
        : url;

    while (true) {
      final decoded = Uri.decodeComponent(segment);

      if (decoded.contains('://')) {
        final nestedUri = Uri.parse(decoded);
        segment = nestedUri.pathSegments.isNotEmpty
            ? nestedUri.pathSegments.last
            : decoded;
      } else if (decoded.contains('/')) {
        segment = decoded.split('/').last;
      } else {
        return decoded;
      }
    }
  }
}

extension ListIdWithStateX on List<IdWithState> {
  List<IdWithState> get inProgress => where(
    (data) => data.state.isInProgress || data.state.isUnsuccessful,
  ).toList();

  List<IdWithState> get completed =>
      where((data) => data.state.isSuccessful).toList();
}
