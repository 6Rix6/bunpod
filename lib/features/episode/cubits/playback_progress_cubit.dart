import 'dart:async';

import 'package:bunpod/bunpod.dart';

class PlaybackProgressCubit extends StreamViewCubit<Duration> {
  PlaybackProgressCubit(this._repository, {required int episodeId})
    : _id = episodeId;

  final int _id;
  final PlaybackProgressRepository _repository;

  @override
  Stream<Duration> watchStream() =>
      _repository.watchProgress(_id).map((d) => d ?? Duration.zero);

  @override
  Duration get throttleTime => Duration(milliseconds: 500);

  @override
  String get id => '$runtimeType $_id';

  @override
  Object? toJsonT(Duration data) => data.inSeconds;

  @override
  Duration fromJsonT(Object? json) => Duration(seconds: json as int);
}
