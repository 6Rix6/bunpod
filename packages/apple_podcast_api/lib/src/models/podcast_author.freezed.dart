// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'podcast_author.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PodcastAuthor {

 String? get wrapperType; String? get artistType; int? get artistId; String? get artistName; String? get artistLinkUrl; String? get primaryGenreName; int? get primaryGenreId; List<String>? get genres; List<String>? get genreIds;
/// Create a copy of PodcastAuthor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PodcastAuthorCopyWith<PodcastAuthor> get copyWith => _$PodcastAuthorCopyWithImpl<PodcastAuthor>(this as PodcastAuthor, _$identity);

  /// Serializes this PodcastAuthor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PodcastAuthor&&(identical(other.wrapperType, wrapperType) || other.wrapperType == wrapperType)&&(identical(other.artistType, artistType) || other.artistType == artistType)&&(identical(other.artistId, artistId) || other.artistId == artistId)&&(identical(other.artistName, artistName) || other.artistName == artistName)&&(identical(other.artistLinkUrl, artistLinkUrl) || other.artistLinkUrl == artistLinkUrl)&&(identical(other.primaryGenreName, primaryGenreName) || other.primaryGenreName == primaryGenreName)&&(identical(other.primaryGenreId, primaryGenreId) || other.primaryGenreId == primaryGenreId)&&const DeepCollectionEquality().equals(other.genres, genres)&&const DeepCollectionEquality().equals(other.genreIds, genreIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wrapperType,artistType,artistId,artistName,artistLinkUrl,primaryGenreName,primaryGenreId,const DeepCollectionEquality().hash(genres),const DeepCollectionEquality().hash(genreIds));

@override
String toString() {
  return 'PodcastAuthor(wrapperType: $wrapperType, artistType: $artistType, artistId: $artistId, artistName: $artistName, artistLinkUrl: $artistLinkUrl, primaryGenreName: $primaryGenreName, primaryGenreId: $primaryGenreId, genres: $genres, genreIds: $genreIds)';
}


}

/// @nodoc
abstract mixin class $PodcastAuthorCopyWith<$Res>  {
  factory $PodcastAuthorCopyWith(PodcastAuthor value, $Res Function(PodcastAuthor) _then) = _$PodcastAuthorCopyWithImpl;
@useResult
$Res call({
 String? wrapperType, String? artistType, int? artistId, String? artistName, String? artistLinkUrl, String? primaryGenreName, int? primaryGenreId, List<String>? genres, List<String>? genreIds
});




}
/// @nodoc
class _$PodcastAuthorCopyWithImpl<$Res>
    implements $PodcastAuthorCopyWith<$Res> {
  _$PodcastAuthorCopyWithImpl(this._self, this._then);

  final PodcastAuthor _self;
  final $Res Function(PodcastAuthor) _then;

/// Create a copy of PodcastAuthor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wrapperType = freezed,Object? artistType = freezed,Object? artistId = freezed,Object? artistName = freezed,Object? artistLinkUrl = freezed,Object? primaryGenreName = freezed,Object? primaryGenreId = freezed,Object? genres = freezed,Object? genreIds = freezed,}) {
  return _then(PodcastAuthor(
wrapperType: freezed == wrapperType ? _self.wrapperType : wrapperType // ignore: cast_nullable_to_non_nullable
as String?,artistType: freezed == artistType ? _self.artistType : artistType // ignore: cast_nullable_to_non_nullable
as String?,artistId: freezed == artistId ? _self.artistId : artistId // ignore: cast_nullable_to_non_nullable
as int?,artistName: freezed == artistName ? _self.artistName : artistName // ignore: cast_nullable_to_non_nullable
as String?,artistLinkUrl: freezed == artistLinkUrl ? _self.artistLinkUrl : artistLinkUrl // ignore: cast_nullable_to_non_nullable
as String?,primaryGenreName: freezed == primaryGenreName ? _self.primaryGenreName : primaryGenreName // ignore: cast_nullable_to_non_nullable
as String?,primaryGenreId: freezed == primaryGenreId ? _self.primaryGenreId : primaryGenreId // ignore: cast_nullable_to_non_nullable
as int?,genres: freezed == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>?,genreIds: freezed == genreIds ? _self.genreIds : genreIds // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PodcastAuthor].
extension PodcastAuthorPatterns on PodcastAuthor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PodcastAuthor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PodcastAuthor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PodcastAuthor value)  $default,){
final _that = this;
switch (_that) {
case _PodcastAuthor():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PodcastAuthor value)?  $default,){
final _that = this;
switch (_that) {
case _PodcastAuthor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? wrapperType,  String? artistType,  int? artistId,  String? artistName,  String? artistLinkUrl,  String? primaryGenreName,  int? primaryGenreId,  List<String>? genres,  List<String>? genreIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PodcastAuthor() when $default != null:
return $default(_that.wrapperType,_that.artistType,_that.artistId,_that.artistName,_that.artistLinkUrl,_that.primaryGenreName,_that.primaryGenreId,_that.genres,_that.genreIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? wrapperType,  String? artistType,  int? artistId,  String? artistName,  String? artistLinkUrl,  String? primaryGenreName,  int? primaryGenreId,  List<String>? genres,  List<String>? genreIds)  $default,) {final _that = this;
switch (_that) {
case _PodcastAuthor():
return $default(_that.wrapperType,_that.artistType,_that.artistId,_that.artistName,_that.artistLinkUrl,_that.primaryGenreName,_that.primaryGenreId,_that.genres,_that.genreIds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? wrapperType,  String? artistType,  int? artistId,  String? artistName,  String? artistLinkUrl,  String? primaryGenreName,  int? primaryGenreId,  List<String>? genres,  List<String>? genreIds)?  $default,) {final _that = this;
switch (_that) {
case _PodcastAuthor() when $default != null:
return $default(_that.wrapperType,_that.artistType,_that.artistId,_that.artistName,_that.artistLinkUrl,_that.primaryGenreName,_that.primaryGenreId,_that.genres,_that.genreIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PodcastAuthor implements PodcastAuthor {
  const _PodcastAuthor({this.wrapperType, this.artistType, this.artistId, this.artistName, this.artistLinkUrl, this.primaryGenreName, this.primaryGenreId,  List<String>? genres,  List<String>? genreIds}): _genres = genres,_genreIds = genreIds;
  factory _PodcastAuthor.fromJson(Map<String, dynamic> json) => _$PodcastAuthorFromJson(json);

@override final  String? wrapperType;
@override final  String? artistType;
@override final  int? artistId;
@override final  String? artistName;
@override final  String? artistLinkUrl;
@override final  String? primaryGenreName;
@override final  int? primaryGenreId;
 final  List<String>? _genres;
@override List<String>? get genres {
  final value = _genres;
  if (value == null) return null;
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _genreIds;
@override List<String>? get genreIds {
  final value = _genreIds;
  if (value == null) return null;
  if (_genreIds is EqualUnmodifiableListView) return _genreIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PodcastAuthor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PodcastAuthorCopyWith<_PodcastAuthor> get copyWith => __$PodcastAuthorCopyWithImpl<_PodcastAuthor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PodcastAuthorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PodcastAuthor&&(identical(other.wrapperType, wrapperType) || other.wrapperType == wrapperType)&&(identical(other.artistType, artistType) || other.artistType == artistType)&&(identical(other.artistId, artistId) || other.artistId == artistId)&&(identical(other.artistName, artistName) || other.artistName == artistName)&&(identical(other.artistLinkUrl, artistLinkUrl) || other.artistLinkUrl == artistLinkUrl)&&(identical(other.primaryGenreName, primaryGenreName) || other.primaryGenreName == primaryGenreName)&&(identical(other.primaryGenreId, primaryGenreId) || other.primaryGenreId == primaryGenreId)&&const DeepCollectionEquality().equals(other._genres, _genres)&&const DeepCollectionEquality().equals(other._genreIds, _genreIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wrapperType,artistType,artistId,artistName,artistLinkUrl,primaryGenreName,primaryGenreId,const DeepCollectionEquality().hash(_genres),const DeepCollectionEquality().hash(_genreIds));

@override
String toString() {
  return 'PodcastAuthor(wrapperType: $wrapperType, artistType: $artistType, artistId: $artistId, artistName: $artistName, artistLinkUrl: $artistLinkUrl, primaryGenreName: $primaryGenreName, primaryGenreId: $primaryGenreId, genres: $genres, genreIds: $genreIds)';
}


}

/// @nodoc
abstract mixin class _$PodcastAuthorCopyWith<$Res> implements $PodcastAuthorCopyWith<$Res> {
  factory _$PodcastAuthorCopyWith(_PodcastAuthor value, $Res Function(_PodcastAuthor) _then) = __$PodcastAuthorCopyWithImpl;
@override @useResult
$Res call({
 String? wrapperType, String? artistType, int? artistId, String? artistName, String? artistLinkUrl, String? primaryGenreName, int? primaryGenreId, List<String>? genres, List<String>? genreIds
});




}
/// @nodoc
class __$PodcastAuthorCopyWithImpl<$Res>
    implements _$PodcastAuthorCopyWith<$Res> {
  __$PodcastAuthorCopyWithImpl(this._self, this._then);

  final _PodcastAuthor _self;
  final $Res Function(_PodcastAuthor) _then;

/// Create a copy of PodcastAuthor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wrapperType = freezed,Object? artistType = freezed,Object? artistId = freezed,Object? artistName = freezed,Object? artistLinkUrl = freezed,Object? primaryGenreName = freezed,Object? primaryGenreId = freezed,Object? genres = freezed,Object? genreIds = freezed,}) {
  return _then(_PodcastAuthor(
wrapperType: freezed == wrapperType ? _self.wrapperType : wrapperType // ignore: cast_nullable_to_non_nullable
as String?,artistType: freezed == artistType ? _self.artistType : artistType // ignore: cast_nullable_to_non_nullable
as String?,artistId: freezed == artistId ? _self.artistId : artistId // ignore: cast_nullable_to_non_nullable
as int?,artistName: freezed == artistName ? _self.artistName : artistName // ignore: cast_nullable_to_non_nullable
as String?,artistLinkUrl: freezed == artistLinkUrl ? _self.artistLinkUrl : artistLinkUrl // ignore: cast_nullable_to_non_nullable
as String?,primaryGenreName: freezed == primaryGenreName ? _self.primaryGenreName : primaryGenreName // ignore: cast_nullable_to_non_nullable
as String?,primaryGenreId: freezed == primaryGenreId ? _self.primaryGenreId : primaryGenreId // ignore: cast_nullable_to_non_nullable
as int?,genres: freezed == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>?,genreIds: freezed == genreIds ? _self._genreIds : genreIds // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
