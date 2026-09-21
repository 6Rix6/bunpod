import 'dart:async';
import 'dart:io';

import 'package:bunpod/bunpod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodeDownloadProgressCubit
    extends Cubit<ViewState<DownloadProgressInfo>> {
  EpisodeDownloadProgressCubit(this._repository, {required Episode episode})
    : _episode = episode,
      super(ViewReady(_repository.getLastProgressOf(episode.audioUrl))) {
    _subscribe();
  }

  final Episode _episode;
  final DownloadRepository _repository;

  StreamSubscription<DownloadProgressInfo>? _subscription;

  String get _url => _episode.audioUrl;

  void _subscribe() {
    _subscription = _repository
        .progressStreamOf(_url)
        .listen((data) => emit(ViewReady(data)));
  }

  Future<void> startDownload(ValueChanged<Object>? onError) async {
    try {
      await _repository.download(_episode);
    } catch (e) {
      onError?.call(e);
    }
  }

  Future<void> pause() => _repository.pause(_url);

  Future<void> resume() => _repository.resume(_url);

  Future<void> cancel() => _repository.cancel(_url);

  Future<void> retry() => _repository.retry(_url);

  Future<File?> getFile() => _repository.downloadedFor(_episode);

  Future<void> deleteFile({bool deleteTask = true}) => _repository
      .deleteDownloadedFor(_episode, deleteTask)
      .run()
      .onError((e, st) {
        final error = e is AppError ? e : UnknownError(e.toString(), st);
        emit(state.copyWithPrevious(ViewFailed(error)));
        return AppEither<void>.right(null);
      });

  Future<void> deleteTask() =>
      _repository.deleteDownloadTaskFor(_url).run().onError((e, st) {
        final error = e is AppError ? e : UnknownError(e.toString(), st);
        emit(state.copyWithPrevious(ViewFailed(error)));
        return AppEither<void>.right(null);
      });

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
