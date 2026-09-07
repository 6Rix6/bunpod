// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
ExploreItem _$ExploreItemFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'host':
          return ExploreHost.fromJson(
            json
          );
                case 'category':
          return ExploreCategory.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'ExploreItem',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$ExploreItem {

 String get name; int get color; List<Channel> get channels;
/// Create a copy of ExploreItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreItemCopyWith<ExploreItem> get copyWith => _$ExploreItemCopyWithImpl<ExploreItem>(this as ExploreItem, _$identity);

  /// Serializes this ExploreItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreItem&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other.channels, channels));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,color,const DeepCollectionEquality().hash(channels));

@override
String toString() {
  return 'ExploreItem(name: $name, color: $color, channels: $channels)';
}


}

/// @nodoc
abstract mixin class $ExploreItemCopyWith<$Res>  {
  factory $ExploreItemCopyWith(ExploreItem value, $Res Function(ExploreItem) _then) = _$ExploreItemCopyWithImpl;
@useResult
$Res call({
 String name, int color, List<Channel> channels
});




}
/// @nodoc
class _$ExploreItemCopyWithImpl<$Res>
    implements $ExploreItemCopyWith<$Res> {
  _$ExploreItemCopyWithImpl(this._self, this._then);

  final ExploreItem _self;
  final $Res Function(ExploreItem) _then;

/// Create a copy of ExploreItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? color = null,Object? channels = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,channels: null == channels ? _self.channels : channels // ignore: cast_nullable_to_non_nullable
as List<Channel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExploreItem].
extension ExploreItemPatterns on ExploreItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ExploreHost value)?  host,TResult Function( ExploreCategory value)?  category,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ExploreHost() when host != null:
return host(_that);case ExploreCategory() when category != null:
return category(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ExploreHost value)  host,required TResult Function( ExploreCategory value)  category,}){
final _that = this;
switch (_that) {
case ExploreHost():
return host(_that);case ExploreCategory():
return category(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ExploreHost value)?  host,TResult? Function( ExploreCategory value)?  category,}){
final _that = this;
switch (_that) {
case ExploreHost() when host != null:
return host(_that);case ExploreCategory() when category != null:
return category(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name,  int color,  List<Channel> channels)?  host,TResult Function( String name,  int color,  List<Channel> channels)?  category,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ExploreHost() when host != null:
return host(_that.name,_that.color,_that.channels);case ExploreCategory() when category != null:
return category(_that.name,_that.color,_that.channels);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name,  int color,  List<Channel> channels)  host,required TResult Function( String name,  int color,  List<Channel> channels)  category,}) {final _that = this;
switch (_that) {
case ExploreHost():
return host(_that.name,_that.color,_that.channels);case ExploreCategory():
return category(_that.name,_that.color,_that.channels);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name,  int color,  List<Channel> channels)?  host,TResult? Function( String name,  int color,  List<Channel> channels)?  category,}) {final _that = this;
switch (_that) {
case ExploreHost() when host != null:
return host(_that.name,_that.color,_that.channels);case ExploreCategory() when category != null:
return category(_that.name,_that.color,_that.channels);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class ExploreHost extends ExploreItem {
  const ExploreHost({required this.name, required this.color, required  List<Channel> channels,  String? $type}): _channels = channels,$type = $type ?? 'host',super._();
  factory ExploreHost.fromJson(Map<String, dynamic> json) => _$ExploreHostFromJson(json);

@override final  String name;
@override final  int color;
 final  List<Channel> _channels;
@override List<Channel> get channels {
  if (_channels is EqualUnmodifiableListView) return _channels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_channels);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ExploreItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreHostCopyWith<ExploreHost> get copyWith => _$ExploreHostCopyWithImpl<ExploreHost>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExploreHostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreHost&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other._channels, _channels));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,color,const DeepCollectionEquality().hash(_channels));

@override
String toString() {
  return 'ExploreItem.host(name: $name, color: $color, channels: $channels)';
}


}

/// @nodoc
abstract mixin class $ExploreHostCopyWith<$Res> implements $ExploreItemCopyWith<$Res> {
  factory $ExploreHostCopyWith(ExploreHost value, $Res Function(ExploreHost) _then) = _$ExploreHostCopyWithImpl;
@override @useResult
$Res call({
 String name, int color, List<Channel> channels
});




}
/// @nodoc
class _$ExploreHostCopyWithImpl<$Res>
    implements $ExploreHostCopyWith<$Res> {
  _$ExploreHostCopyWithImpl(this._self, this._then);

  final ExploreHost _self;
  final $Res Function(ExploreHost) _then;

/// Create a copy of ExploreItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? color = null,Object? channels = null,}) {
  return _then(ExploreHost(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,channels: null == channels ? _self._channels : channels // ignore: cast_nullable_to_non_nullable
as List<Channel>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ExploreCategory extends ExploreItem {
  const ExploreCategory({required this.name, required this.color, required  List<Channel> channels,  String? $type}): _channels = channels,$type = $type ?? 'category',super._();
  factory ExploreCategory.fromJson(Map<String, dynamic> json) => _$ExploreCategoryFromJson(json);

@override final  String name;
@override final  int color;
 final  List<Channel> _channels;
@override List<Channel> get channels {
  if (_channels is EqualUnmodifiableListView) return _channels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_channels);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ExploreItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreCategoryCopyWith<ExploreCategory> get copyWith => _$ExploreCategoryCopyWithImpl<ExploreCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExploreCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreCategory&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other._channels, _channels));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,color,const DeepCollectionEquality().hash(_channels));

@override
String toString() {
  return 'ExploreItem.category(name: $name, color: $color, channels: $channels)';
}


}

/// @nodoc
abstract mixin class $ExploreCategoryCopyWith<$Res> implements $ExploreItemCopyWith<$Res> {
  factory $ExploreCategoryCopyWith(ExploreCategory value, $Res Function(ExploreCategory) _then) = _$ExploreCategoryCopyWithImpl;
@override @useResult
$Res call({
 String name, int color, List<Channel> channels
});




}
/// @nodoc
class _$ExploreCategoryCopyWithImpl<$Res>
    implements $ExploreCategoryCopyWith<$Res> {
  _$ExploreCategoryCopyWithImpl(this._self, this._then);

  final ExploreCategory _self;
  final $Res Function(ExploreCategory) _then;

/// Create a copy of ExploreItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? color = null,Object? channels = null,}) {
  return _then(ExploreCategory(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,channels: null == channels ? _self._channels : channels // ignore: cast_nullable_to_non_nullable
as List<Channel>,
  ));
}


}

// dart format on
