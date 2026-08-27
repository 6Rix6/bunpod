// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayerState {

/// The episode handed to [PlayerCubit.load]. Playback metadata comes from
/// the handler, this only anchors the UI to a feed entry.
 Episode? get episode; bool get playing; AudioProcessingState get processing; Duration get position; Duration get buffered; Duration get duration;
/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerStateCopyWith<PlayerState> get copyWith => _$PlayerStateCopyWithImpl<PlayerState>(this as PlayerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerState&&(identical(other.episode, episode) || other.episode == episode)&&(identical(other.playing, playing) || other.playing == playing)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.position, position) || other.position == position)&&(identical(other.buffered, buffered) || other.buffered == buffered)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode => Object.hash(runtimeType,episode,playing,processing,position,buffered,duration);

@override
String toString() {
  return 'PlayerState(episode: $episode, playing: $playing, processing: $processing, position: $position, buffered: $buffered, duration: $duration)';
}


}

/// @nodoc
abstract mixin class $PlayerStateCopyWith<$Res>  {
  factory $PlayerStateCopyWith(PlayerState value, $Res Function(PlayerState) _then) = _$PlayerStateCopyWithImpl;
@useResult
$Res call({
 Episode? episode, bool playing, AudioProcessingState processing, Duration position, Duration buffered, Duration duration
});


$EpisodeCopyWith<$Res>? get episode;

}
/// @nodoc
class _$PlayerStateCopyWithImpl<$Res>
    implements $PlayerStateCopyWith<$Res> {
  _$PlayerStateCopyWithImpl(this._self, this._then);

  final PlayerState _self;
  final $Res Function(PlayerState) _then;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? episode = freezed,Object? playing = null,Object? processing = null,Object? position = null,Object? buffered = null,Object? duration = null,}) {
  return _then(PlayerState(
episode: freezed == episode ? _self.episode : episode // ignore: cast_nullable_to_non_nullable
as Episode?,playing: null == playing ? _self.playing : playing // ignore: cast_nullable_to_non_nullable
as bool,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as AudioProcessingState,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,buffered: null == buffered ? _self.buffered : buffered // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}
/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EpisodeCopyWith<$Res>? get episode {
    if (_self.episode == null) {
    return null;
  }

  return $EpisodeCopyWith<$Res>(_self.episode!, (value) {
    return _then(_self.copyWith(episode: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlayerState].
extension PlayerStatePatterns on PlayerState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerState value)  $default,){
final _that = this;
switch (_that) {
case _PlayerState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerState value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Episode? episode,  bool playing,  AudioProcessingState processing,  Duration position,  Duration buffered,  Duration duration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
return $default(_that.episode,_that.playing,_that.processing,_that.position,_that.buffered,_that.duration);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Episode? episode,  bool playing,  AudioProcessingState processing,  Duration position,  Duration buffered,  Duration duration)  $default,) {final _that = this;
switch (_that) {
case _PlayerState():
return $default(_that.episode,_that.playing,_that.processing,_that.position,_that.buffered,_that.duration);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Episode? episode,  bool playing,  AudioProcessingState processing,  Duration position,  Duration buffered,  Duration duration)?  $default,) {final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
return $default(_that.episode,_that.playing,_that.processing,_that.position,_that.buffered,_that.duration);case _:
  return null;

}
}

}

/// @nodoc


class _PlayerState implements PlayerState {
  const _PlayerState({this.episode, this.playing = false, this.processing = AudioProcessingState.idle, this.position = Duration.zero, this.buffered = Duration.zero, this.duration = Duration.zero});
  

/// The episode handed to [PlayerCubit.load]. Playback metadata comes from
/// the handler, this only anchors the UI to a feed entry.
@override final  Episode? episode;
@override@JsonKey() final  bool playing;
@override@JsonKey() final  AudioProcessingState processing;
@override@JsonKey() final  Duration position;
@override@JsonKey() final  Duration buffered;
@override@JsonKey() final  Duration duration;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerStateCopyWith<_PlayerState> get copyWith => __$PlayerStateCopyWithImpl<_PlayerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerState&&(identical(other.episode, episode) || other.episode == episode)&&(identical(other.playing, playing) || other.playing == playing)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.position, position) || other.position == position)&&(identical(other.buffered, buffered) || other.buffered == buffered)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode => Object.hash(runtimeType,episode,playing,processing,position,buffered,duration);

@override
String toString() {
  return 'PlayerState(episode: $episode, playing: $playing, processing: $processing, position: $position, buffered: $buffered, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$PlayerStateCopyWith<$Res> implements $PlayerStateCopyWith<$Res> {
  factory _$PlayerStateCopyWith(_PlayerState value, $Res Function(_PlayerState) _then) = __$PlayerStateCopyWithImpl;
@override @useResult
$Res call({
 Episode? episode, bool playing, AudioProcessingState processing, Duration position, Duration buffered, Duration duration
});


@override $EpisodeCopyWith<$Res>? get episode;

}
/// @nodoc
class __$PlayerStateCopyWithImpl<$Res>
    implements _$PlayerStateCopyWith<$Res> {
  __$PlayerStateCopyWithImpl(this._self, this._then);

  final _PlayerState _self;
  final $Res Function(_PlayerState) _then;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? episode = freezed,Object? playing = null,Object? processing = null,Object? position = null,Object? buffered = null,Object? duration = null,}) {
  return _then(_PlayerState(
episode: freezed == episode ? _self.episode : episode // ignore: cast_nullable_to_non_nullable
as Episode?,playing: null == playing ? _self.playing : playing // ignore: cast_nullable_to_non_nullable
as bool,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as AudioProcessingState,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,buffered: null == buffered ? _self.buffered : buffered // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EpisodeCopyWith<$Res>? get episode {
    if (_self.episode == null) {
    return null;
  }

  return $EpisodeCopyWith<$Res>(_self.episode!, (value) {
    return _then(_self.copyWith(episode: value));
  });
}
}

// dart format on
