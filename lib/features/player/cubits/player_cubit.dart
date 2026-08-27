import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:bunpod/bunpod.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_cubit.freezed.dart';

/// Immutable snapshot of the shared player for the UI.
@freezed
abstract class PlayerState with _$PlayerState {
  const factory PlayerState({
    /// The episode handed to [PlayerCubit.load]. Playback metadata comes from
    /// the handler, this only anchors the UI to a feed entry.
    Episode? episode,
    @Default(false) bool playing,
    @Default(AudioProcessingState.idle) AudioProcessingState processing,
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration buffered,
    @Default(Duration.zero) Duration duration,
  }) = _PlayerState;
}

extension PlayerStateX on PlayerState {
  /// Real stream length once known; falls back to the feed value before the
  /// source loads so the UI never jumps to zero.
  Duration get total =>
      duration > Duration.zero ? duration : (episode?.total ?? Duration.zero);

  double get progress =>
      total.inSeconds == 0 ? 0 : position.inSeconds / total.inSeconds;

  Duration get remaining => total - position;
}

/// Single shared player state, backed by the OS-integrated audio handler.
class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit(this._handler) : super(const PlayerState()) {
    _subscribe();
  }

  final AudioHandlerService _handler;

  static const Duration skipDelta = Duration(seconds: 10);

  StreamSubscription<PlaybackState>? _playbackSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration>? _bufferedSubscription;
  StreamSubscription<Duration?>? _durationSubscription;

  void _subscribe() {
    _playbackSubscription = _handler.playbackState.listen((state) {
      emit(
        this.state.copyWith(
          playing: state.playing,
          processing: state.processingState,
          position: state.updatePosition,
          buffered: state.bufferedPosition,
        ),
      );
    });
    _positionSubscription = _handler.positionStream.listen((position) {
      emit(state.copyWith(position: position));
    });
    _bufferedSubscription = _handler.bufferedPositionStream.listen((
      buffered,
    ) {
      emit(state.copyWith(buffered: buffered));
    });
    _durationSubscription = _handler.durationStream.listen((duration) {
      if (duration != null) emit(state.copyWith(duration: duration));
    });
  }

  /// Switches to [episode] unless it is already loaded.
  Future<void> load(Episode episode) async {
    if (!identical(state.episode, episode)) {
      emit(state.copyWith(episode: episode));
    }
    await _handler.load(episode);
  }

  Future<void> toggle() async {
    if (state.playing) {
      await _handler.pause();
    } else {
      await _handler.play();
    }
  }

  Future<void> seekTo(Duration position) => _handler.seek(position);

  Future<void> skipBackward() => _skip(-skipDelta);

  Future<void> skipForward() => _skip(skipDelta);

  Future<void> _skip(Duration delta) {
    final Duration target = state.position + delta;
    return seekTo(
      target < Duration.zero ? Duration.zero : target,
    );
  }

  @override
  Future<void> close() async {
    await _playbackSubscription?.cancel();
    await _positionSubscription?.cancel();
    await _bufferedSubscription?.cancel();
    await _durationSubscription?.cancel();
    await super.close();
  }
}
