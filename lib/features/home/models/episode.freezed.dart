// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'episode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Episode {

 Bucket get bucket; String get channel; String get host; String get title; String get date; Color get seed; String get image;/// Placeholder stream URL until real feed data arrives.
 String get audioUrl; Duration get total; Duration get listened;
/// Create a copy of Episode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpisodeCopyWith<Episode> get copyWith => _$EpisodeCopyWithImpl<Episode>(this as Episode, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Episode&&(identical(other.bucket, bucket) || other.bucket == bucket)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.host, host) || other.host == host)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.seed, seed) || other.seed == seed)&&(identical(other.image, image) || other.image == image)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.total, total) || other.total == total)&&(identical(other.listened, listened) || other.listened == listened));
}


@override
int get hashCode => Object.hash(runtimeType,bucket,channel,host,title,date,seed,image,audioUrl,total,listened);

@override
String toString() {
  return 'Episode(bucket: $bucket, channel: $channel, host: $host, title: $title, date: $date, seed: $seed, image: $image, audioUrl: $audioUrl, total: $total, listened: $listened)';
}


}

/// @nodoc
abstract mixin class $EpisodeCopyWith<$Res>  {
  factory $EpisodeCopyWith(Episode value, $Res Function(Episode) _then) = _$EpisodeCopyWithImpl;
@useResult
$Res call({
 Bucket bucket, String channel, String host, String title, String date, Color seed, String image, String audioUrl, Duration total, Duration listened
});




}
/// @nodoc
class _$EpisodeCopyWithImpl<$Res>
    implements $EpisodeCopyWith<$Res> {
  _$EpisodeCopyWithImpl(this._self, this._then);

  final Episode _self;
  final $Res Function(Episode) _then;

/// Create a copy of Episode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bucket = null,Object? channel = null,Object? host = null,Object? title = null,Object? date = null,Object? seed = null,Object? image = null,Object? audioUrl = null,Object? total = null,Object? listened = null,}) {
  return _then(Episode(
bucket: null == bucket ? _self.bucket : bucket // ignore: cast_nullable_to_non_nullable
as Bucket,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,seed: null == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as Color,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,audioUrl: null == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Duration,listened: null == listened ? _self.listened : listened // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [Episode].
extension EpisodePatterns on Episode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Episode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Episode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Episode value)  $default,){
final _that = this;
switch (_that) {
case _Episode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Episode value)?  $default,){
final _that = this;
switch (_that) {
case _Episode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Bucket bucket,  String channel,  String host,  String title,  String date,  Color seed,  String image,  String audioUrl,  Duration total,  Duration listened)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Episode() when $default != null:
return $default(_that.bucket,_that.channel,_that.host,_that.title,_that.date,_that.seed,_that.image,_that.audioUrl,_that.total,_that.listened);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Bucket bucket,  String channel,  String host,  String title,  String date,  Color seed,  String image,  String audioUrl,  Duration total,  Duration listened)  $default,) {final _that = this;
switch (_that) {
case _Episode():
return $default(_that.bucket,_that.channel,_that.host,_that.title,_that.date,_that.seed,_that.image,_that.audioUrl,_that.total,_that.listened);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Bucket bucket,  String channel,  String host,  String title,  String date,  Color seed,  String image,  String audioUrl,  Duration total,  Duration listened)?  $default,) {final _that = this;
switch (_that) {
case _Episode() when $default != null:
return $default(_that.bucket,_that.channel,_that.host,_that.title,_that.date,_that.seed,_that.image,_that.audioUrl,_that.total,_that.listened);case _:
  return null;

}
}

}

/// @nodoc


class _Episode implements Episode {
  const _Episode({required this.bucket, required this.channel, required this.host, required this.title, required this.date, required this.seed, required this.image, required this.audioUrl, required this.total, required this.listened});
  

@override final  Bucket bucket;
@override final  String channel;
@override final  String host;
@override final  String title;
@override final  String date;
@override final  Color seed;
@override final  String image;
/// Placeholder stream URL until real feed data arrives.
@override final  String audioUrl;
@override final  Duration total;
@override final  Duration listened;

/// Create a copy of Episode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpisodeCopyWith<_Episode> get copyWith => __$EpisodeCopyWithImpl<_Episode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Episode&&(identical(other.bucket, bucket) || other.bucket == bucket)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.host, host) || other.host == host)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.seed, seed) || other.seed == seed)&&(identical(other.image, image) || other.image == image)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.total, total) || other.total == total)&&(identical(other.listened, listened) || other.listened == listened));
}


@override
int get hashCode => Object.hash(runtimeType,bucket,channel,host,title,date,seed,image,audioUrl,total,listened);

@override
String toString() {
  return 'Episode(bucket: $bucket, channel: $channel, host: $host, title: $title, date: $date, seed: $seed, image: $image, audioUrl: $audioUrl, total: $total, listened: $listened)';
}


}

/// @nodoc
abstract mixin class _$EpisodeCopyWith<$Res> implements $EpisodeCopyWith<$Res> {
  factory _$EpisodeCopyWith(_Episode value, $Res Function(_Episode) _then) = __$EpisodeCopyWithImpl;
@override @useResult
$Res call({
 Bucket bucket, String channel, String host, String title, String date, Color seed, String image, String audioUrl, Duration total, Duration listened
});




}
/// @nodoc
class __$EpisodeCopyWithImpl<$Res>
    implements _$EpisodeCopyWith<$Res> {
  __$EpisodeCopyWithImpl(this._self, this._then);

  final _Episode _self;
  final $Res Function(_Episode) _then;

/// Create a copy of Episode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bucket = null,Object? channel = null,Object? host = null,Object? title = null,Object? date = null,Object? seed = null,Object? image = null,Object? audioUrl = null,Object? total = null,Object? listened = null,}) {
  return _then(_Episode(
bucket: null == bucket ? _self.bucket : bucket // ignore: cast_nullable_to_non_nullable
as Bucket,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,seed: null == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as Color,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,audioUrl: null == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Duration,listened: null == listened ? _self.listened : listened // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
