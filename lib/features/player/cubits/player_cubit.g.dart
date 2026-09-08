// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerState _$PlayerStateFromJson(Map<String, dynamic> json) => _PlayerState(
  episode: json['episode'] == null
      ? null
      : Episode.fromJson(json['episode'] as Map<String, dynamic>),
  playing: json['playing'] as bool? ?? false,
  processing:
      $enumDecodeNullable(_$AudioProcessingStateEnumMap, json['processing']) ??
      AudioProcessingState.idle,
  position: json['position'] == null
      ? Duration.zero
      : Duration(microseconds: (json['position'] as num).toInt()),
  buffered: json['buffered'] == null
      ? Duration.zero
      : Duration(microseconds: (json['buffered'] as num).toInt()),
  duration: json['duration'] == null
      ? Duration.zero
      : Duration(microseconds: (json['duration'] as num).toInt()),
);

Map<String, dynamic> _$PlayerStateToJson(_PlayerState instance) =>
    <String, dynamic>{
      'episode': instance.episode,
      'playing': instance.playing,
      'processing': _$AudioProcessingStateEnumMap[instance.processing]!,
      'position': instance.position.inMicroseconds,
      'buffered': instance.buffered.inMicroseconds,
      'duration': instance.duration.inMicroseconds,
    };

const _$AudioProcessingStateEnumMap = {
  AudioProcessingState.idle: 'idle',
  AudioProcessingState.loading: 'loading',
  AudioProcessingState.buffering: 'buffering',
  AudioProcessingState.ready: 'ready',
  AudioProcessingState.completed: 'completed',
  AudioProcessingState.error: 'error',
};
