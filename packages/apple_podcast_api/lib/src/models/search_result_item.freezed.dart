// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchResultItem {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResultItem);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchResultItem()';
}


}

/// @nodoc
class $SearchResultItemCopyWith<$Res>  {
$SearchResultItemCopyWith(SearchResultItem _, $Res Function(SearchResultItem) __);
}


/// Adds pattern-matching-related methods to [SearchResultItem].
extension SearchResultItemPatterns on SearchResultItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PodcastResult value)?  podcast,TResult Function( AuthorResult value)?  author,TResult Function( EpisodeResult value)?  episode,TResult Function( UnknownResult value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PodcastResult() when podcast != null:
return podcast(_that);case AuthorResult() when author != null:
return author(_that);case EpisodeResult() when episode != null:
return episode(_that);case UnknownResult() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PodcastResult value)  podcast,required TResult Function( AuthorResult value)  author,required TResult Function( EpisodeResult value)  episode,required TResult Function( UnknownResult value)  unknown,}){
final _that = this;
switch (_that) {
case PodcastResult():
return podcast(_that);case AuthorResult():
return author(_that);case EpisodeResult():
return episode(_that);case UnknownResult():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PodcastResult value)?  podcast,TResult? Function( AuthorResult value)?  author,TResult? Function( EpisodeResult value)?  episode,TResult? Function( UnknownResult value)?  unknown,}){
final _that = this;
switch (_that) {
case PodcastResult() when podcast != null:
return podcast(_that);case AuthorResult() when author != null:
return author(_that);case EpisodeResult() when episode != null:
return episode(_that);case UnknownResult() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ItunesPodcast podcast)?  podcast,TResult Function( PodcastAuthor author)?  author,TResult Function( PodcastEpisode episode)?  episode,TResult Function( Map<String, dynamic> raw)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PodcastResult() when podcast != null:
return podcast(_that.podcast);case AuthorResult() when author != null:
return author(_that.author);case EpisodeResult() when episode != null:
return episode(_that.episode);case UnknownResult() when unknown != null:
return unknown(_that.raw);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ItunesPodcast podcast)  podcast,required TResult Function( PodcastAuthor author)  author,required TResult Function( PodcastEpisode episode)  episode,required TResult Function( Map<String, dynamic> raw)  unknown,}) {final _that = this;
switch (_that) {
case PodcastResult():
return podcast(_that.podcast);case AuthorResult():
return author(_that.author);case EpisodeResult():
return episode(_that.episode);case UnknownResult():
return unknown(_that.raw);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ItunesPodcast podcast)?  podcast,TResult? Function( PodcastAuthor author)?  author,TResult? Function( PodcastEpisode episode)?  episode,TResult? Function( Map<String, dynamic> raw)?  unknown,}) {final _that = this;
switch (_that) {
case PodcastResult() when podcast != null:
return podcast(_that.podcast);case AuthorResult() when author != null:
return author(_that.author);case EpisodeResult() when episode != null:
return episode(_that.episode);case UnknownResult() when unknown != null:
return unknown(_that.raw);case _:
  return null;

}
}

}

/// @nodoc


class PodcastResult implements SearchResultItem {
  const PodcastResult(this.podcast);
  

 final  ItunesPodcast podcast;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PodcastResultCopyWith<PodcastResult> get copyWith => _$PodcastResultCopyWithImpl<PodcastResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PodcastResult&&(identical(other.podcast, podcast) || other.podcast == podcast));
}


@override
int get hashCode => Object.hash(runtimeType,podcast);

@override
String toString() {
  return 'SearchResultItem.podcast(podcast: $podcast)';
}


}

/// @nodoc
abstract mixin class $PodcastResultCopyWith<$Res> implements $SearchResultItemCopyWith<$Res> {
  factory $PodcastResultCopyWith(PodcastResult value, $Res Function(PodcastResult) _then) = _$PodcastResultCopyWithImpl;
@useResult
$Res call({
 ItunesPodcast podcast
});


$ItunesPodcastCopyWith<$Res> get podcast;

}
/// @nodoc
class _$PodcastResultCopyWithImpl<$Res>
    implements $PodcastResultCopyWith<$Res> {
  _$PodcastResultCopyWithImpl(this._self, this._then);

  final PodcastResult _self;
  final $Res Function(PodcastResult) _then;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? podcast = null,}) {
  return _then(PodcastResult(
null == podcast ? _self.podcast : podcast // ignore: cast_nullable_to_non_nullable
as ItunesPodcast,
  ));
}

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ItunesPodcastCopyWith<$Res> get podcast {
  
  return $ItunesPodcastCopyWith<$Res>(_self.podcast, (value) {
    return _then(_self.copyWith(podcast: value));
  });
}
}

/// @nodoc


class AuthorResult implements SearchResultItem {
  const AuthorResult(this.author);
  

 final  PodcastAuthor author;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthorResultCopyWith<AuthorResult> get copyWith => _$AuthorResultCopyWithImpl<AuthorResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthorResult&&(identical(other.author, author) || other.author == author));
}


@override
int get hashCode => Object.hash(runtimeType,author);

@override
String toString() {
  return 'SearchResultItem.author(author: $author)';
}


}

/// @nodoc
abstract mixin class $AuthorResultCopyWith<$Res> implements $SearchResultItemCopyWith<$Res> {
  factory $AuthorResultCopyWith(AuthorResult value, $Res Function(AuthorResult) _then) = _$AuthorResultCopyWithImpl;
@useResult
$Res call({
 PodcastAuthor author
});


$PodcastAuthorCopyWith<$Res> get author;

}
/// @nodoc
class _$AuthorResultCopyWithImpl<$Res>
    implements $AuthorResultCopyWith<$Res> {
  _$AuthorResultCopyWithImpl(this._self, this._then);

  final AuthorResult _self;
  final $Res Function(AuthorResult) _then;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? author = null,}) {
  return _then(AuthorResult(
null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PodcastAuthor,
  ));
}

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PodcastAuthorCopyWith<$Res> get author {
  
  return $PodcastAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}

/// @nodoc


class EpisodeResult implements SearchResultItem {
  const EpisodeResult(this.episode);
  

 final  PodcastEpisode episode;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpisodeResultCopyWith<EpisodeResult> get copyWith => _$EpisodeResultCopyWithImpl<EpisodeResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EpisodeResult&&(identical(other.episode, episode) || other.episode == episode));
}


@override
int get hashCode => Object.hash(runtimeType,episode);

@override
String toString() {
  return 'SearchResultItem.episode(episode: $episode)';
}


}

/// @nodoc
abstract mixin class $EpisodeResultCopyWith<$Res> implements $SearchResultItemCopyWith<$Res> {
  factory $EpisodeResultCopyWith(EpisodeResult value, $Res Function(EpisodeResult) _then) = _$EpisodeResultCopyWithImpl;
@useResult
$Res call({
 PodcastEpisode episode
});


$PodcastEpisodeCopyWith<$Res> get episode;

}
/// @nodoc
class _$EpisodeResultCopyWithImpl<$Res>
    implements $EpisodeResultCopyWith<$Res> {
  _$EpisodeResultCopyWithImpl(this._self, this._then);

  final EpisodeResult _self;
  final $Res Function(EpisodeResult) _then;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? episode = null,}) {
  return _then(EpisodeResult(
null == episode ? _self.episode : episode // ignore: cast_nullable_to_non_nullable
as PodcastEpisode,
  ));
}

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PodcastEpisodeCopyWith<$Res> get episode {
  
  return $PodcastEpisodeCopyWith<$Res>(_self.episode, (value) {
    return _then(_self.copyWith(episode: value));
  });
}
}

/// @nodoc


class UnknownResult implements SearchResultItem {
  const UnknownResult( Map<String, dynamic> raw): _raw = raw;
  

 final  Map<String, dynamic> _raw;
 Map<String, dynamic> get raw {
  if (_raw is EqualUnmodifiableMapView) return _raw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_raw);
}


/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownResultCopyWith<UnknownResult> get copyWith => _$UnknownResultCopyWithImpl<UnknownResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownResult&&const DeepCollectionEquality().equals(other._raw, _raw));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_raw));

@override
String toString() {
  return 'SearchResultItem.unknown(raw: $raw)';
}


}

/// @nodoc
abstract mixin class $UnknownResultCopyWith<$Res> implements $SearchResultItemCopyWith<$Res> {
  factory $UnknownResultCopyWith(UnknownResult value, $Res Function(UnknownResult) _then) = _$UnknownResultCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> raw
});




}
/// @nodoc
class _$UnknownResultCopyWithImpl<$Res>
    implements $UnknownResultCopyWith<$Res> {
  _$UnknownResultCopyWithImpl(this._self, this._then);

  final UnknownResult _self;
  final $Res Function(UnknownResult) _then;

/// Create a copy of SearchResultItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? raw = null,}) {
  return _then(UnknownResult(
null == raw ? _self._raw : raw // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
