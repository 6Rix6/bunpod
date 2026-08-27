import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:bunpod/bunpod.dart';
import 'package:just_audio/just_audio.dart';

/// Bridges [AudioPlayer] to the OS media session (notification, headset
/// buttons, lock screen). Single-episode for now — no queue.
class AudioHandlerService extends BaseAudioHandler with SeekHandler {
  AudioHandlerService() {
    _init();
  }

  static const _processingStateMap = {
    ProcessingState.idle: AudioProcessingState.idle,
    ProcessingState.loading: AudioProcessingState.loading,
    ProcessingState.buffering: AudioProcessingState.buffering,
    ProcessingState.ready: AudioProcessingState.ready,
    ProcessingState.completed: AudioProcessingState.completed,
  };

  static const _skipDelta = Duration(seconds: 10);

  final _player = AudioPlayer();

  Stream<Duration> get positionStream => _player.positionStream;

  Stream<Duration?> get durationStream => _player.durationStream;

  Stream<Duration> get bufferedPositionStream =>
      _player.bufferedPositionStream;

  StreamSubscription<ProcessingState>? _processingSubscription;
  StreamSubscription<Duration?>? _durationSubscription;

  Future<void> _init() async {
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);

    // Queue comes later — completed episodes park at the start, paused.
    _processingSubscription = _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        seek(Duration.zero);
        pause();
      }
    });

    // Patch the real stream length into the notification once known.
    _durationSubscription = _player.durationStream.listen((duration) {
      final MediaItem? item = mediaItem.valueOrNull;
      if (item != null && duration != null && item.duration != duration) {
        mediaItem.add(item.copyWith(duration: duration));
      }
    });
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    final bool isCompleted =
        _player.processingState == ProcessingState.completed;
    return PlaybackState(
      controls: [
        MediaControl.rewind,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.rewind,
        MediaAction.fastForward,
      },
      androidCompactActionIndices: const [0, 1, 2],
      processingState: _processingStateMap[_player.processingState]!,
      playing: _player.playing && !isCompleted,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
    );
  }

  /// Loads [episode] for playback. Loading the already-loaded episode is a
  /// no-op, so reopening the player never restarts the stream.
  Future<void> load(Episode episode) async {
    if (mediaItem.valueOrNull?.id == episode.id &&
        _player.audioSource != null) {
      return;
    }

    mediaItem.add(
      MediaItem(
        id: episode.id,
        title: episode.title,
        artist: episode.channel,
        artUri: Uri.parse(episode.image),
      ),
    );

    await _player.setAudioSource(
      AudioSource.uri(Uri.parse(episode.audioUrl)),
    );
  }

  static Future<AudioHandlerService> initAudioService(
    String channelId,
    String channelName,
  ) async {
    return await AudioService.init(
      builder: () => AudioHandlerService(),
      config: AudioServiceConfig(
        androidNotificationChannelId: channelId,
        androidNotificationChannelName: channelName,
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
      ),
    );
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> rewind() async {
    await _seekBy(-_skipDelta);
  }

  @override
  Future<void> fastForward() async {
    await _seekBy(_skipDelta);
  }

  Future<void> _seekBy(Duration delta) async {
    final Duration position = _player.position;
    final Duration? duration = _player.duration;
    Duration target = position + delta;
    if (target < Duration.zero) target = Duration.zero;
    if (duration != null && target > duration) target = duration;
    await _player.seek(target);
  }

  Future<void> dispose() async {
    await _processingSubscription?.cancel();
    await _durationSubscription?.cancel();
    await _player.dispose();
  }
}
