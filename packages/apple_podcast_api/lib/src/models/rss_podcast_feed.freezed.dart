// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rss_podcast_feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RSSPodcastFeed {

 Uri? get url; String? get title; String? get link; String? get description; String? get language; String? get copyright; String? get generator;/// Author of the show (`itunes:author`).
 String? get author; String? get ownerName; String? get ownerEmail; String? get imageUrl; List<String> get categories; bool? get explicit; DateTime? get lastBuildDate;/// Unique global identifier (`podcast:guid`).
 String? get guid;/// Whether the feed is protected from directory ingestion
/// (`podcast:locked`).
 bool? get locked; String? get lockedOwner; List<FeedFunding> get funding; List<FeedPerson> get persons; List<RSSFeedEpisode> get episodes;
/// Create a copy of RSSPodcastFeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RSSPodcastFeedCopyWith<RSSPodcastFeed> get copyWith => _$RSSPodcastFeedCopyWithImpl<RSSPodcastFeed>(this as RSSPodcastFeed, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RSSPodcastFeed&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.link, link) || other.link == link)&&(identical(other.description, description) || other.description == description)&&(identical(other.language, language) || other.language == language)&&(identical(other.copyright, copyright) || other.copyright == copyright)&&(identical(other.generator, generator) || other.generator == generator)&&(identical(other.author, author) || other.author == author)&&(identical(other.ownerName, ownerName) || other.ownerName == ownerName)&&(identical(other.ownerEmail, ownerEmail) || other.ownerEmail == ownerEmail)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.explicit, explicit) || other.explicit == explicit)&&(identical(other.lastBuildDate, lastBuildDate) || other.lastBuildDate == lastBuildDate)&&(identical(other.guid, guid) || other.guid == guid)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.lockedOwner, lockedOwner) || other.lockedOwner == lockedOwner)&&const DeepCollectionEquality().equals(other.funding, funding)&&const DeepCollectionEquality().equals(other.persons, persons)&&const DeepCollectionEquality().equals(other.episodes, episodes));
}


@override
int get hashCode => Object.hashAll([runtimeType,url,title,link,description,language,copyright,generator,author,ownerName,ownerEmail,imageUrl,const DeepCollectionEquality().hash(categories),explicit,lastBuildDate,guid,locked,lockedOwner,const DeepCollectionEquality().hash(funding),const DeepCollectionEquality().hash(persons),const DeepCollectionEquality().hash(episodes)]);

@override
String toString() {
  return 'RSSPodcastFeed(url: $url, title: $title, link: $link, description: $description, language: $language, copyright: $copyright, generator: $generator, author: $author, ownerName: $ownerName, ownerEmail: $ownerEmail, imageUrl: $imageUrl, categories: $categories, explicit: $explicit, lastBuildDate: $lastBuildDate, guid: $guid, locked: $locked, lockedOwner: $lockedOwner, funding: $funding, persons: $persons, episodes: $episodes)';
}


}

/// @nodoc
abstract mixin class $RSSPodcastFeedCopyWith<$Res>  {
  factory $RSSPodcastFeedCopyWith(RSSPodcastFeed value, $Res Function(RSSPodcastFeed) _then) = _$RSSPodcastFeedCopyWithImpl;
@useResult
$Res call({
 Uri? url, String? title, String? link, String? description, String? language, String? copyright, String? generator, String? author, String? ownerName, String? ownerEmail, String? imageUrl, List<String> categories, bool? explicit, DateTime? lastBuildDate, String? guid, bool? locked, String? lockedOwner, List<FeedFunding> funding, List<FeedPerson> persons, List<RSSFeedEpisode> episodes
});




}
/// @nodoc
class _$RSSPodcastFeedCopyWithImpl<$Res>
    implements $RSSPodcastFeedCopyWith<$Res> {
  _$RSSPodcastFeedCopyWithImpl(this._self, this._then);

  final RSSPodcastFeed _self;
  final $Res Function(RSSPodcastFeed) _then;

/// Create a copy of RSSPodcastFeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? title = freezed,Object? link = freezed,Object? description = freezed,Object? language = freezed,Object? copyright = freezed,Object? generator = freezed,Object? author = freezed,Object? ownerName = freezed,Object? ownerEmail = freezed,Object? imageUrl = freezed,Object? categories = null,Object? explicit = freezed,Object? lastBuildDate = freezed,Object? guid = freezed,Object? locked = freezed,Object? lockedOwner = freezed,Object? funding = null,Object? persons = null,Object? episodes = null,}) {
  return _then(RSSPodcastFeed(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,copyright: freezed == copyright ? _self.copyright : copyright // ignore: cast_nullable_to_non_nullable
as String?,generator: freezed == generator ? _self.generator : generator // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,ownerName: freezed == ownerName ? _self.ownerName : ownerName // ignore: cast_nullable_to_non_nullable
as String?,ownerEmail: freezed == ownerEmail ? _self.ownerEmail : ownerEmail // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,explicit: freezed == explicit ? _self.explicit : explicit // ignore: cast_nullable_to_non_nullable
as bool?,lastBuildDate: freezed == lastBuildDate ? _self.lastBuildDate : lastBuildDate // ignore: cast_nullable_to_non_nullable
as DateTime?,guid: freezed == guid ? _self.guid : guid // ignore: cast_nullable_to_non_nullable
as String?,locked: freezed == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool?,lockedOwner: freezed == lockedOwner ? _self.lockedOwner : lockedOwner // ignore: cast_nullable_to_non_nullable
as String?,funding: null == funding ? _self.funding : funding // ignore: cast_nullable_to_non_nullable
as List<FeedFunding>,persons: null == persons ? _self.persons : persons // ignore: cast_nullable_to_non_nullable
as List<FeedPerson>,episodes: null == episodes ? _self.episodes : episodes // ignore: cast_nullable_to_non_nullable
as List<RSSFeedEpisode>,
  ));
}

}


/// Adds pattern-matching-related methods to [RSSPodcastFeed].
extension RSSPodcastFeedPatterns on RSSPodcastFeed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RSSPodcastFeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RSSPodcastFeed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RSSPodcastFeed value)  $default,){
final _that = this;
switch (_that) {
case _RSSPodcastFeed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RSSPodcastFeed value)?  $default,){
final _that = this;
switch (_that) {
case _RSSPodcastFeed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Uri? url,  String? title,  String? link,  String? description,  String? language,  String? copyright,  String? generator,  String? author,  String? ownerName,  String? ownerEmail,  String? imageUrl,  List<String> categories,  bool? explicit,  DateTime? lastBuildDate,  String? guid,  bool? locked,  String? lockedOwner,  List<FeedFunding> funding,  List<FeedPerson> persons,  List<RSSFeedEpisode> episodes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RSSPodcastFeed() when $default != null:
return $default(_that.url,_that.title,_that.link,_that.description,_that.language,_that.copyright,_that.generator,_that.author,_that.ownerName,_that.ownerEmail,_that.imageUrl,_that.categories,_that.explicit,_that.lastBuildDate,_that.guid,_that.locked,_that.lockedOwner,_that.funding,_that.persons,_that.episodes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Uri? url,  String? title,  String? link,  String? description,  String? language,  String? copyright,  String? generator,  String? author,  String? ownerName,  String? ownerEmail,  String? imageUrl,  List<String> categories,  bool? explicit,  DateTime? lastBuildDate,  String? guid,  bool? locked,  String? lockedOwner,  List<FeedFunding> funding,  List<FeedPerson> persons,  List<RSSFeedEpisode> episodes)  $default,) {final _that = this;
switch (_that) {
case _RSSPodcastFeed():
return $default(_that.url,_that.title,_that.link,_that.description,_that.language,_that.copyright,_that.generator,_that.author,_that.ownerName,_that.ownerEmail,_that.imageUrl,_that.categories,_that.explicit,_that.lastBuildDate,_that.guid,_that.locked,_that.lockedOwner,_that.funding,_that.persons,_that.episodes);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Uri? url,  String? title,  String? link,  String? description,  String? language,  String? copyright,  String? generator,  String? author,  String? ownerName,  String? ownerEmail,  String? imageUrl,  List<String> categories,  bool? explicit,  DateTime? lastBuildDate,  String? guid,  bool? locked,  String? lockedOwner,  List<FeedFunding> funding,  List<FeedPerson> persons,  List<RSSFeedEpisode> episodes)?  $default,) {final _that = this;
switch (_that) {
case _RSSPodcastFeed() when $default != null:
return $default(_that.url,_that.title,_that.link,_that.description,_that.language,_that.copyright,_that.generator,_that.author,_that.ownerName,_that.ownerEmail,_that.imageUrl,_that.categories,_that.explicit,_that.lastBuildDate,_that.guid,_that.locked,_that.lockedOwner,_that.funding,_that.persons,_that.episodes);case _:
  return null;

}
}

}

/// @nodoc


class _RSSPodcastFeed implements RSSPodcastFeed {
  const _RSSPodcastFeed({this.url, this.title, this.link, this.description, this.language, this.copyright, this.generator, this.author, this.ownerName, this.ownerEmail, this.imageUrl,  List<String> categories = const [], this.explicit, this.lastBuildDate, this.guid, this.locked, this.lockedOwner,  List<FeedFunding> funding = const [],  List<FeedPerson> persons = const [],  List<RSSFeedEpisode> episodes = const []}): _categories = categories,_funding = funding,_persons = persons,_episodes = episodes;
  

@override final  Uri? url;
@override final  String? title;
@override final  String? link;
@override final  String? description;
@override final  String? language;
@override final  String? copyright;
@override final  String? generator;
/// Author of the show (`itunes:author`).
@override final  String? author;
@override final  String? ownerName;
@override final  String? ownerEmail;
@override final  String? imageUrl;
 final  List<String> _categories;
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override final  bool? explicit;
@override final  DateTime? lastBuildDate;
/// Unique global identifier (`podcast:guid`).
@override final  String? guid;
/// Whether the feed is protected from directory ingestion
/// (`podcast:locked`).
@override final  bool? locked;
@override final  String? lockedOwner;
 final  List<FeedFunding> _funding;
@override@JsonKey() List<FeedFunding> get funding {
  if (_funding is EqualUnmodifiableListView) return _funding;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_funding);
}

 final  List<FeedPerson> _persons;
@override@JsonKey() List<FeedPerson> get persons {
  if (_persons is EqualUnmodifiableListView) return _persons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_persons);
}

 final  List<RSSFeedEpisode> _episodes;
@override@JsonKey() List<RSSFeedEpisode> get episodes {
  if (_episodes is EqualUnmodifiableListView) return _episodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_episodes);
}


/// Create a copy of RSSPodcastFeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RSSPodcastFeedCopyWith<_RSSPodcastFeed> get copyWith => __$RSSPodcastFeedCopyWithImpl<_RSSPodcastFeed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RSSPodcastFeed&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.link, link) || other.link == link)&&(identical(other.description, description) || other.description == description)&&(identical(other.language, language) || other.language == language)&&(identical(other.copyright, copyright) || other.copyright == copyright)&&(identical(other.generator, generator) || other.generator == generator)&&(identical(other.author, author) || other.author == author)&&(identical(other.ownerName, ownerName) || other.ownerName == ownerName)&&(identical(other.ownerEmail, ownerEmail) || other.ownerEmail == ownerEmail)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.explicit, explicit) || other.explicit == explicit)&&(identical(other.lastBuildDate, lastBuildDate) || other.lastBuildDate == lastBuildDate)&&(identical(other.guid, guid) || other.guid == guid)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.lockedOwner, lockedOwner) || other.lockedOwner == lockedOwner)&&const DeepCollectionEquality().equals(other._funding, _funding)&&const DeepCollectionEquality().equals(other._persons, _persons)&&const DeepCollectionEquality().equals(other._episodes, _episodes));
}


@override
int get hashCode => Object.hashAll([runtimeType,url,title,link,description,language,copyright,generator,author,ownerName,ownerEmail,imageUrl,const DeepCollectionEquality().hash(_categories),explicit,lastBuildDate,guid,locked,lockedOwner,const DeepCollectionEquality().hash(_funding),const DeepCollectionEquality().hash(_persons),const DeepCollectionEquality().hash(_episodes)]);

@override
String toString() {
  return 'RSSPodcastFeed(url: $url, title: $title, link: $link, description: $description, language: $language, copyright: $copyright, generator: $generator, author: $author, ownerName: $ownerName, ownerEmail: $ownerEmail, imageUrl: $imageUrl, categories: $categories, explicit: $explicit, lastBuildDate: $lastBuildDate, guid: $guid, locked: $locked, lockedOwner: $lockedOwner, funding: $funding, persons: $persons, episodes: $episodes)';
}


}

/// @nodoc
abstract mixin class _$RSSPodcastFeedCopyWith<$Res> implements $RSSPodcastFeedCopyWith<$Res> {
  factory _$RSSPodcastFeedCopyWith(_RSSPodcastFeed value, $Res Function(_RSSPodcastFeed) _then) = __$RSSPodcastFeedCopyWithImpl;
@override @useResult
$Res call({
 Uri? url, String? title, String? link, String? description, String? language, String? copyright, String? generator, String? author, String? ownerName, String? ownerEmail, String? imageUrl, List<String> categories, bool? explicit, DateTime? lastBuildDate, String? guid, bool? locked, String? lockedOwner, List<FeedFunding> funding, List<FeedPerson> persons, List<RSSFeedEpisode> episodes
});




}
/// @nodoc
class __$RSSPodcastFeedCopyWithImpl<$Res>
    implements _$RSSPodcastFeedCopyWith<$Res> {
  __$RSSPodcastFeedCopyWithImpl(this._self, this._then);

  final _RSSPodcastFeed _self;
  final $Res Function(_RSSPodcastFeed) _then;

/// Create a copy of RSSPodcastFeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? title = freezed,Object? link = freezed,Object? description = freezed,Object? language = freezed,Object? copyright = freezed,Object? generator = freezed,Object? author = freezed,Object? ownerName = freezed,Object? ownerEmail = freezed,Object? imageUrl = freezed,Object? categories = null,Object? explicit = freezed,Object? lastBuildDate = freezed,Object? guid = freezed,Object? locked = freezed,Object? lockedOwner = freezed,Object? funding = null,Object? persons = null,Object? episodes = null,}) {
  return _then(_RSSPodcastFeed(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,copyright: freezed == copyright ? _self.copyright : copyright // ignore: cast_nullable_to_non_nullable
as String?,generator: freezed == generator ? _self.generator : generator // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,ownerName: freezed == ownerName ? _self.ownerName : ownerName // ignore: cast_nullable_to_non_nullable
as String?,ownerEmail: freezed == ownerEmail ? _self.ownerEmail : ownerEmail // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,explicit: freezed == explicit ? _self.explicit : explicit // ignore: cast_nullable_to_non_nullable
as bool?,lastBuildDate: freezed == lastBuildDate ? _self.lastBuildDate : lastBuildDate // ignore: cast_nullable_to_non_nullable
as DateTime?,guid: freezed == guid ? _self.guid : guid // ignore: cast_nullable_to_non_nullable
as String?,locked: freezed == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool?,lockedOwner: freezed == lockedOwner ? _self.lockedOwner : lockedOwner // ignore: cast_nullable_to_non_nullable
as String?,funding: null == funding ? _self._funding : funding // ignore: cast_nullable_to_non_nullable
as List<FeedFunding>,persons: null == persons ? _self._persons : persons // ignore: cast_nullable_to_non_nullable
as List<FeedPerson>,episodes: null == episodes ? _self._episodes : episodes // ignore: cast_nullable_to_non_nullable
as List<RSSFeedEpisode>,
  ));
}


}

/// @nodoc
mixin _$FeedFunding {

 Uri? get url; String? get description;
/// Create a copy of FeedFunding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedFundingCopyWith<FeedFunding> get copyWith => _$FeedFundingCopyWithImpl<FeedFunding>(this as FeedFunding, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedFunding&&(identical(other.url, url) || other.url == url)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,url,description);

@override
String toString() {
  return 'FeedFunding(url: $url, description: $description)';
}


}

/// @nodoc
abstract mixin class $FeedFundingCopyWith<$Res>  {
  factory $FeedFundingCopyWith(FeedFunding value, $Res Function(FeedFunding) _then) = _$FeedFundingCopyWithImpl;
@useResult
$Res call({
 Uri? url, String? description
});




}
/// @nodoc
class _$FeedFundingCopyWithImpl<$Res>
    implements $FeedFundingCopyWith<$Res> {
  _$FeedFundingCopyWithImpl(this._self, this._then);

  final FeedFunding _self;
  final $Res Function(FeedFunding) _then;

/// Create a copy of FeedFunding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? description = freezed,}) {
  return _then(FeedFunding(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedFunding].
extension FeedFundingPatterns on FeedFunding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedFunding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedFunding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedFunding value)  $default,){
final _that = this;
switch (_that) {
case _FeedFunding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedFunding value)?  $default,){
final _that = this;
switch (_that) {
case _FeedFunding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Uri? url,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedFunding() when $default != null:
return $default(_that.url,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Uri? url,  String? description)  $default,) {final _that = this;
switch (_that) {
case _FeedFunding():
return $default(_that.url,_that.description);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Uri? url,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _FeedFunding() when $default != null:
return $default(_that.url,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _FeedFunding implements FeedFunding {
  const _FeedFunding({this.url, this.description});
  

@override final  Uri? url;
@override final  String? description;

/// Create a copy of FeedFunding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedFundingCopyWith<_FeedFunding> get copyWith => __$FeedFundingCopyWithImpl<_FeedFunding>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedFunding&&(identical(other.url, url) || other.url == url)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,url,description);

@override
String toString() {
  return 'FeedFunding(url: $url, description: $description)';
}


}

/// @nodoc
abstract mixin class _$FeedFundingCopyWith<$Res> implements $FeedFundingCopyWith<$Res> {
  factory _$FeedFundingCopyWith(_FeedFunding value, $Res Function(_FeedFunding) _then) = __$FeedFundingCopyWithImpl;
@override @useResult
$Res call({
 Uri? url, String? description
});




}
/// @nodoc
class __$FeedFundingCopyWithImpl<$Res>
    implements _$FeedFundingCopyWith<$Res> {
  __$FeedFundingCopyWithImpl(this._self, this._then);

  final _FeedFunding _self;
  final $Res Function(_FeedFunding) _then;

/// Create a copy of FeedFunding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? description = freezed,}) {
  return _then(_FeedFunding(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$FeedPerson {

 String get name; String? get role; String? get group; Uri? get imageUrl; Uri? get url;
/// Create a copy of FeedPerson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedPersonCopyWith<FeedPerson> get copyWith => _$FeedPersonCopyWithImpl<FeedPerson>(this as FeedPerson, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedPerson&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&(identical(other.group, group) || other.group == group)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,name,role,group,imageUrl,url);

@override
String toString() {
  return 'FeedPerson(name: $name, role: $role, group: $group, imageUrl: $imageUrl, url: $url)';
}


}

/// @nodoc
abstract mixin class $FeedPersonCopyWith<$Res>  {
  factory $FeedPersonCopyWith(FeedPerson value, $Res Function(FeedPerson) _then) = _$FeedPersonCopyWithImpl;
@useResult
$Res call({
 String name, String? role, String? group, Uri? imageUrl, Uri? url
});




}
/// @nodoc
class _$FeedPersonCopyWithImpl<$Res>
    implements $FeedPersonCopyWith<$Res> {
  _$FeedPersonCopyWithImpl(this._self, this._then);

  final FeedPerson _self;
  final $Res Function(FeedPerson) _then;

/// Create a copy of FeedPerson
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? role = freezed,Object? group = freezed,Object? imageUrl = freezed,Object? url = freezed,}) {
  return _then(FeedPerson(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as Uri?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedPerson].
extension FeedPersonPatterns on FeedPerson {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedPerson value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedPerson() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedPerson value)  $default,){
final _that = this;
switch (_that) {
case _FeedPerson():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedPerson value)?  $default,){
final _that = this;
switch (_that) {
case _FeedPerson() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? role,  String? group,  Uri? imageUrl,  Uri? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedPerson() when $default != null:
return $default(_that.name,_that.role,_that.group,_that.imageUrl,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? role,  String? group,  Uri? imageUrl,  Uri? url)  $default,) {final _that = this;
switch (_that) {
case _FeedPerson():
return $default(_that.name,_that.role,_that.group,_that.imageUrl,_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? role,  String? group,  Uri? imageUrl,  Uri? url)?  $default,) {final _that = this;
switch (_that) {
case _FeedPerson() when $default != null:
return $default(_that.name,_that.role,_that.group,_that.imageUrl,_that.url);case _:
  return null;

}
}

}

/// @nodoc


class _FeedPerson implements FeedPerson {
  const _FeedPerson({required this.name, this.role, this.group, this.imageUrl, this.url});
  

@override final  String name;
@override final  String? role;
@override final  String? group;
@override final  Uri? imageUrl;
@override final  Uri? url;

/// Create a copy of FeedPerson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedPersonCopyWith<_FeedPerson> get copyWith => __$FeedPersonCopyWithImpl<_FeedPerson>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedPerson&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&(identical(other.group, group) || other.group == group)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,name,role,group,imageUrl,url);

@override
String toString() {
  return 'FeedPerson(name: $name, role: $role, group: $group, imageUrl: $imageUrl, url: $url)';
}


}

/// @nodoc
abstract mixin class _$FeedPersonCopyWith<$Res> implements $FeedPersonCopyWith<$Res> {
  factory _$FeedPersonCopyWith(_FeedPerson value, $Res Function(_FeedPerson) _then) = __$FeedPersonCopyWithImpl;
@override @useResult
$Res call({
 String name, String? role, String? group, Uri? imageUrl, Uri? url
});




}
/// @nodoc
class __$FeedPersonCopyWithImpl<$Res>
    implements _$FeedPersonCopyWith<$Res> {
  __$FeedPersonCopyWithImpl(this._self, this._then);

  final _FeedPerson _self;
  final $Res Function(_FeedPerson) _then;

/// Create a copy of FeedPerson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? role = freezed,Object? group = freezed,Object? imageUrl = freezed,Object? url = freezed,}) {
  return _then(_FeedPerson(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as Uri?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri?,
  ));
}


}

/// @nodoc
mixin _$FeedTranscript {

 Uri? get url; String? get type; String? get language;
/// Create a copy of FeedTranscript
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedTranscriptCopyWith<FeedTranscript> get copyWith => _$FeedTranscriptCopyWithImpl<FeedTranscript>(this as FeedTranscript, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedTranscript&&(identical(other.url, url) || other.url == url)&&(identical(other.type, type) || other.type == type)&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,url,type,language);

@override
String toString() {
  return 'FeedTranscript(url: $url, type: $type, language: $language)';
}


}

/// @nodoc
abstract mixin class $FeedTranscriptCopyWith<$Res>  {
  factory $FeedTranscriptCopyWith(FeedTranscript value, $Res Function(FeedTranscript) _then) = _$FeedTranscriptCopyWithImpl;
@useResult
$Res call({
 Uri? url, String? type, String? language
});




}
/// @nodoc
class _$FeedTranscriptCopyWithImpl<$Res>
    implements $FeedTranscriptCopyWith<$Res> {
  _$FeedTranscriptCopyWithImpl(this._self, this._then);

  final FeedTranscript _self;
  final $Res Function(FeedTranscript) _then;

/// Create a copy of FeedTranscript
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? type = freezed,Object? language = freezed,}) {
  return _then(FeedTranscript(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedTranscript].
extension FeedTranscriptPatterns on FeedTranscript {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedTranscript value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedTranscript() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedTranscript value)  $default,){
final _that = this;
switch (_that) {
case _FeedTranscript():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedTranscript value)?  $default,){
final _that = this;
switch (_that) {
case _FeedTranscript() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Uri? url,  String? type,  String? language)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedTranscript() when $default != null:
return $default(_that.url,_that.type,_that.language);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Uri? url,  String? type,  String? language)  $default,) {final _that = this;
switch (_that) {
case _FeedTranscript():
return $default(_that.url,_that.type,_that.language);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Uri? url,  String? type,  String? language)?  $default,) {final _that = this;
switch (_that) {
case _FeedTranscript() when $default != null:
return $default(_that.url,_that.type,_that.language);case _:
  return null;

}
}

}

/// @nodoc


class _FeedTranscript implements FeedTranscript {
  const _FeedTranscript({this.url, this.type, this.language});
  

@override final  Uri? url;
@override final  String? type;
@override final  String? language;

/// Create a copy of FeedTranscript
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedTranscriptCopyWith<_FeedTranscript> get copyWith => __$FeedTranscriptCopyWithImpl<_FeedTranscript>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedTranscript&&(identical(other.url, url) || other.url == url)&&(identical(other.type, type) || other.type == type)&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,url,type,language);

@override
String toString() {
  return 'FeedTranscript(url: $url, type: $type, language: $language)';
}


}

/// @nodoc
abstract mixin class _$FeedTranscriptCopyWith<$Res> implements $FeedTranscriptCopyWith<$Res> {
  factory _$FeedTranscriptCopyWith(_FeedTranscript value, $Res Function(_FeedTranscript) _then) = __$FeedTranscriptCopyWithImpl;
@override @useResult
$Res call({
 Uri? url, String? type, String? language
});




}
/// @nodoc
class __$FeedTranscriptCopyWithImpl<$Res>
    implements _$FeedTranscriptCopyWith<$Res> {
  __$FeedTranscriptCopyWithImpl(this._self, this._then);

  final _FeedTranscript _self;
  final $Res Function(_FeedTranscript) _then;

/// Create a copy of FeedTranscript
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? type = freezed,Object? language = freezed,}) {
  return _then(_FeedTranscript(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$RSSFeedEpisode {

 String? get guid; String? get title; String? get description;/// HTML body from `content:encoded`, if present.
 String? get htmlDescription; String? get link; String? get author; DateTime? get publishedAt; String? get audioUrl; int? get audioSizeBytes; String? get audioType; Duration? get duration; int? get episodeNumber; int? get seasonNumber; RSSFeedEpisodeType? get episodeType; String? get imageUrl; Uri? get chaptersUrl; String? get chaptersType; List<FeedTranscript> get transcripts; List<FeedPerson> get persons;
/// Create a copy of RSSFeedEpisode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RSSFeedEpisodeCopyWith<RSSFeedEpisode> get copyWith => _$RSSFeedEpisodeCopyWithImpl<RSSFeedEpisode>(this as RSSFeedEpisode, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RSSFeedEpisode&&(identical(other.guid, guid) || other.guid == guid)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.htmlDescription, htmlDescription) || other.htmlDescription == htmlDescription)&&(identical(other.link, link) || other.link == link)&&(identical(other.author, author) || other.author == author)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.audioSizeBytes, audioSizeBytes) || other.audioSizeBytes == audioSizeBytes)&&(identical(other.audioType, audioType) || other.audioType == audioType)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.episodeNumber, episodeNumber) || other.episodeNumber == episodeNumber)&&(identical(other.seasonNumber, seasonNumber) || other.seasonNumber == seasonNumber)&&(identical(other.episodeType, episodeType) || other.episodeType == episodeType)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.chaptersUrl, chaptersUrl) || other.chaptersUrl == chaptersUrl)&&(identical(other.chaptersType, chaptersType) || other.chaptersType == chaptersType)&&const DeepCollectionEquality().equals(other.transcripts, transcripts)&&const DeepCollectionEquality().equals(other.persons, persons));
}


@override
int get hashCode => Object.hashAll([runtimeType,guid,title,description,htmlDescription,link,author,publishedAt,audioUrl,audioSizeBytes,audioType,duration,episodeNumber,seasonNumber,episodeType,imageUrl,chaptersUrl,chaptersType,const DeepCollectionEquality().hash(transcripts),const DeepCollectionEquality().hash(persons)]);

@override
String toString() {
  return 'RSSFeedEpisode(guid: $guid, title: $title, description: $description, htmlDescription: $htmlDescription, link: $link, author: $author, publishedAt: $publishedAt, audioUrl: $audioUrl, audioSizeBytes: $audioSizeBytes, audioType: $audioType, duration: $duration, episodeNumber: $episodeNumber, seasonNumber: $seasonNumber, episodeType: $episodeType, imageUrl: $imageUrl, chaptersUrl: $chaptersUrl, chaptersType: $chaptersType, transcripts: $transcripts, persons: $persons)';
}


}

/// @nodoc
abstract mixin class $RSSFeedEpisodeCopyWith<$Res>  {
  factory $RSSFeedEpisodeCopyWith(RSSFeedEpisode value, $Res Function(RSSFeedEpisode) _then) = _$RSSFeedEpisodeCopyWithImpl;
@useResult
$Res call({
 String? guid, String? title, String? description, String? htmlDescription, String? link, String? author, DateTime? publishedAt, String? audioUrl, int? audioSizeBytes, String? audioType, Duration? duration, int? episodeNumber, int? seasonNumber, RSSFeedEpisodeType? episodeType, String? imageUrl, Uri? chaptersUrl, String? chaptersType, List<FeedTranscript> transcripts, List<FeedPerson> persons
});




}
/// @nodoc
class _$RSSFeedEpisodeCopyWithImpl<$Res>
    implements $RSSFeedEpisodeCopyWith<$Res> {
  _$RSSFeedEpisodeCopyWithImpl(this._self, this._then);

  final RSSFeedEpisode _self;
  final $Res Function(RSSFeedEpisode) _then;

/// Create a copy of RSSFeedEpisode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? guid = freezed,Object? title = freezed,Object? description = freezed,Object? htmlDescription = freezed,Object? link = freezed,Object? author = freezed,Object? publishedAt = freezed,Object? audioUrl = freezed,Object? audioSizeBytes = freezed,Object? audioType = freezed,Object? duration = freezed,Object? episodeNumber = freezed,Object? seasonNumber = freezed,Object? episodeType = freezed,Object? imageUrl = freezed,Object? chaptersUrl = freezed,Object? chaptersType = freezed,Object? transcripts = null,Object? persons = null,}) {
  return _then(RSSFeedEpisode(
guid: freezed == guid ? _self.guid : guid // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,htmlDescription: freezed == htmlDescription ? _self.htmlDescription : htmlDescription // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,audioSizeBytes: freezed == audioSizeBytes ? _self.audioSizeBytes : audioSizeBytes // ignore: cast_nullable_to_non_nullable
as int?,audioType: freezed == audioType ? _self.audioType : audioType // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,episodeNumber: freezed == episodeNumber ? _self.episodeNumber : episodeNumber // ignore: cast_nullable_to_non_nullable
as int?,seasonNumber: freezed == seasonNumber ? _self.seasonNumber : seasonNumber // ignore: cast_nullable_to_non_nullable
as int?,episodeType: freezed == episodeType ? _self.episodeType : episodeType // ignore: cast_nullable_to_non_nullable
as RSSFeedEpisodeType?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,chaptersUrl: freezed == chaptersUrl ? _self.chaptersUrl : chaptersUrl // ignore: cast_nullable_to_non_nullable
as Uri?,chaptersType: freezed == chaptersType ? _self.chaptersType : chaptersType // ignore: cast_nullable_to_non_nullable
as String?,transcripts: null == transcripts ? _self.transcripts : transcripts // ignore: cast_nullable_to_non_nullable
as List<FeedTranscript>,persons: null == persons ? _self.persons : persons // ignore: cast_nullable_to_non_nullable
as List<FeedPerson>,
  ));
}

}


/// Adds pattern-matching-related methods to [RSSFeedEpisode].
extension RSSFeedEpisodePatterns on RSSFeedEpisode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RSSFeedEpisode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RSSFeedEpisode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RSSFeedEpisode value)  $default,){
final _that = this;
switch (_that) {
case _RSSFeedEpisode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RSSFeedEpisode value)?  $default,){
final _that = this;
switch (_that) {
case _RSSFeedEpisode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? guid,  String? title,  String? description,  String? htmlDescription,  String? link,  String? author,  DateTime? publishedAt,  String? audioUrl,  int? audioSizeBytes,  String? audioType,  Duration? duration,  int? episodeNumber,  int? seasonNumber,  RSSFeedEpisodeType? episodeType,  String? imageUrl,  Uri? chaptersUrl,  String? chaptersType,  List<FeedTranscript> transcripts,  List<FeedPerson> persons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RSSFeedEpisode() when $default != null:
return $default(_that.guid,_that.title,_that.description,_that.htmlDescription,_that.link,_that.author,_that.publishedAt,_that.audioUrl,_that.audioSizeBytes,_that.audioType,_that.duration,_that.episodeNumber,_that.seasonNumber,_that.episodeType,_that.imageUrl,_that.chaptersUrl,_that.chaptersType,_that.transcripts,_that.persons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? guid,  String? title,  String? description,  String? htmlDescription,  String? link,  String? author,  DateTime? publishedAt,  String? audioUrl,  int? audioSizeBytes,  String? audioType,  Duration? duration,  int? episodeNumber,  int? seasonNumber,  RSSFeedEpisodeType? episodeType,  String? imageUrl,  Uri? chaptersUrl,  String? chaptersType,  List<FeedTranscript> transcripts,  List<FeedPerson> persons)  $default,) {final _that = this;
switch (_that) {
case _RSSFeedEpisode():
return $default(_that.guid,_that.title,_that.description,_that.htmlDescription,_that.link,_that.author,_that.publishedAt,_that.audioUrl,_that.audioSizeBytes,_that.audioType,_that.duration,_that.episodeNumber,_that.seasonNumber,_that.episodeType,_that.imageUrl,_that.chaptersUrl,_that.chaptersType,_that.transcripts,_that.persons);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? guid,  String? title,  String? description,  String? htmlDescription,  String? link,  String? author,  DateTime? publishedAt,  String? audioUrl,  int? audioSizeBytes,  String? audioType,  Duration? duration,  int? episodeNumber,  int? seasonNumber,  RSSFeedEpisodeType? episodeType,  String? imageUrl,  Uri? chaptersUrl,  String? chaptersType,  List<FeedTranscript> transcripts,  List<FeedPerson> persons)?  $default,) {final _that = this;
switch (_that) {
case _RSSFeedEpisode() when $default != null:
return $default(_that.guid,_that.title,_that.description,_that.htmlDescription,_that.link,_that.author,_that.publishedAt,_that.audioUrl,_that.audioSizeBytes,_that.audioType,_that.duration,_that.episodeNumber,_that.seasonNumber,_that.episodeType,_that.imageUrl,_that.chaptersUrl,_that.chaptersType,_that.transcripts,_that.persons);case _:
  return null;

}
}

}

/// @nodoc


class _RSSFeedEpisode implements RSSFeedEpisode {
  const _RSSFeedEpisode({this.guid, this.title, this.description, this.htmlDescription, this.link, this.author, this.publishedAt, this.audioUrl, this.audioSizeBytes, this.audioType, this.duration, this.episodeNumber, this.seasonNumber, this.episodeType, this.imageUrl, this.chaptersUrl, this.chaptersType,  List<FeedTranscript> transcripts = const [],  List<FeedPerson> persons = const []}): _transcripts = transcripts,_persons = persons;
  

@override final  String? guid;
@override final  String? title;
@override final  String? description;
/// HTML body from `content:encoded`, if present.
@override final  String? htmlDescription;
@override final  String? link;
@override final  String? author;
@override final  DateTime? publishedAt;
@override final  String? audioUrl;
@override final  int? audioSizeBytes;
@override final  String? audioType;
@override final  Duration? duration;
@override final  int? episodeNumber;
@override final  int? seasonNumber;
@override final  RSSFeedEpisodeType? episodeType;
@override final  String? imageUrl;
@override final  Uri? chaptersUrl;
@override final  String? chaptersType;
 final  List<FeedTranscript> _transcripts;
@override@JsonKey() List<FeedTranscript> get transcripts {
  if (_transcripts is EqualUnmodifiableListView) return _transcripts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transcripts);
}

 final  List<FeedPerson> _persons;
@override@JsonKey() List<FeedPerson> get persons {
  if (_persons is EqualUnmodifiableListView) return _persons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_persons);
}


/// Create a copy of RSSFeedEpisode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RSSFeedEpisodeCopyWith<_RSSFeedEpisode> get copyWith => __$RSSFeedEpisodeCopyWithImpl<_RSSFeedEpisode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RSSFeedEpisode&&(identical(other.guid, guid) || other.guid == guid)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.htmlDescription, htmlDescription) || other.htmlDescription == htmlDescription)&&(identical(other.link, link) || other.link == link)&&(identical(other.author, author) || other.author == author)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.audioSizeBytes, audioSizeBytes) || other.audioSizeBytes == audioSizeBytes)&&(identical(other.audioType, audioType) || other.audioType == audioType)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.episodeNumber, episodeNumber) || other.episodeNumber == episodeNumber)&&(identical(other.seasonNumber, seasonNumber) || other.seasonNumber == seasonNumber)&&(identical(other.episodeType, episodeType) || other.episodeType == episodeType)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.chaptersUrl, chaptersUrl) || other.chaptersUrl == chaptersUrl)&&(identical(other.chaptersType, chaptersType) || other.chaptersType == chaptersType)&&const DeepCollectionEquality().equals(other._transcripts, _transcripts)&&const DeepCollectionEquality().equals(other._persons, _persons));
}


@override
int get hashCode => Object.hashAll([runtimeType,guid,title,description,htmlDescription,link,author,publishedAt,audioUrl,audioSizeBytes,audioType,duration,episodeNumber,seasonNumber,episodeType,imageUrl,chaptersUrl,chaptersType,const DeepCollectionEquality().hash(_transcripts),const DeepCollectionEquality().hash(_persons)]);

@override
String toString() {
  return 'RSSFeedEpisode(guid: $guid, title: $title, description: $description, htmlDescription: $htmlDescription, link: $link, author: $author, publishedAt: $publishedAt, audioUrl: $audioUrl, audioSizeBytes: $audioSizeBytes, audioType: $audioType, duration: $duration, episodeNumber: $episodeNumber, seasonNumber: $seasonNumber, episodeType: $episodeType, imageUrl: $imageUrl, chaptersUrl: $chaptersUrl, chaptersType: $chaptersType, transcripts: $transcripts, persons: $persons)';
}


}

/// @nodoc
abstract mixin class _$RSSFeedEpisodeCopyWith<$Res> implements $RSSFeedEpisodeCopyWith<$Res> {
  factory _$RSSFeedEpisodeCopyWith(_RSSFeedEpisode value, $Res Function(_RSSFeedEpisode) _then) = __$RSSFeedEpisodeCopyWithImpl;
@override @useResult
$Res call({
 String? guid, String? title, String? description, String? htmlDescription, String? link, String? author, DateTime? publishedAt, String? audioUrl, int? audioSizeBytes, String? audioType, Duration? duration, int? episodeNumber, int? seasonNumber, RSSFeedEpisodeType? episodeType, String? imageUrl, Uri? chaptersUrl, String? chaptersType, List<FeedTranscript> transcripts, List<FeedPerson> persons
});




}
/// @nodoc
class __$RSSFeedEpisodeCopyWithImpl<$Res>
    implements _$RSSFeedEpisodeCopyWith<$Res> {
  __$RSSFeedEpisodeCopyWithImpl(this._self, this._then);

  final _RSSFeedEpisode _self;
  final $Res Function(_RSSFeedEpisode) _then;

/// Create a copy of RSSFeedEpisode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? guid = freezed,Object? title = freezed,Object? description = freezed,Object? htmlDescription = freezed,Object? link = freezed,Object? author = freezed,Object? publishedAt = freezed,Object? audioUrl = freezed,Object? audioSizeBytes = freezed,Object? audioType = freezed,Object? duration = freezed,Object? episodeNumber = freezed,Object? seasonNumber = freezed,Object? episodeType = freezed,Object? imageUrl = freezed,Object? chaptersUrl = freezed,Object? chaptersType = freezed,Object? transcripts = null,Object? persons = null,}) {
  return _then(_RSSFeedEpisode(
guid: freezed == guid ? _self.guid : guid // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,htmlDescription: freezed == htmlDescription ? _self.htmlDescription : htmlDescription // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,audioSizeBytes: freezed == audioSizeBytes ? _self.audioSizeBytes : audioSizeBytes // ignore: cast_nullable_to_non_nullable
as int?,audioType: freezed == audioType ? _self.audioType : audioType // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,episodeNumber: freezed == episodeNumber ? _self.episodeNumber : episodeNumber // ignore: cast_nullable_to_non_nullable
as int?,seasonNumber: freezed == seasonNumber ? _self.seasonNumber : seasonNumber // ignore: cast_nullable_to_non_nullable
as int?,episodeType: freezed == episodeType ? _self.episodeType : episodeType // ignore: cast_nullable_to_non_nullable
as RSSFeedEpisodeType?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,chaptersUrl: freezed == chaptersUrl ? _self.chaptersUrl : chaptersUrl // ignore: cast_nullable_to_non_nullable
as Uri?,chaptersType: freezed == chaptersType ? _self.chaptersType : chaptersType // ignore: cast_nullable_to_non_nullable
as String?,transcripts: null == transcripts ? _self._transcripts : transcripts // ignore: cast_nullable_to_non_nullable
as List<FeedTranscript>,persons: null == persons ? _self._persons : persons // ignore: cast_nullable_to_non_nullable
as List<FeedPerson>,
  ));
}


}

// dart format on
