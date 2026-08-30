// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApiFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiFailure()';
}


}

/// @nodoc
class $ApiFailureCopyWith<$Res>  {
$ApiFailureCopyWith(ApiFailure _, $Res Function(ApiFailure) __);
}


/// Adds pattern-matching-related methods to [ApiFailure].
extension ApiFailurePatterns on ApiFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NetworkFailure value)?  network,TResult Function( CancelledFailure value)?  cancelled,TResult Function( HttpFailure value)?  http,TResult Function( ParseFailure value)?  parse,TResult Function( UnknownFailure value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case CancelledFailure() when cancelled != null:
return cancelled(_that);case HttpFailure() when http != null:
return http(_that);case ParseFailure() when parse != null:
return parse(_that);case UnknownFailure() when unknown != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NetworkFailure value)  network,required TResult Function( CancelledFailure value)  cancelled,required TResult Function( HttpFailure value)  http,required TResult Function( ParseFailure value)  parse,required TResult Function( UnknownFailure value)  unknown,}){
final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that);case CancelledFailure():
return cancelled(_that);case HttpFailure():
return http(_that);case ParseFailure():
return parse(_that);case UnknownFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NetworkFailure value)?  network,TResult? Function( CancelledFailure value)?  cancelled,TResult? Function( HttpFailure value)?  http,TResult? Function( ParseFailure value)?  parse,TResult? Function( UnknownFailure value)?  unknown,}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case CancelledFailure() when cancelled != null:
return cancelled(_that);case HttpFailure() when http != null:
return http(_that);case ParseFailure() when parse != null:
return parse(_that);case UnknownFailure() when unknown != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message,  Object? cause)?  network,TResult Function()?  cancelled,TResult Function( int statusCode,  String message,  Object? responseBody)?  http,TResult Function( Object message,  StackTrace? stackTrace)?  parse,TResult Function( Object error,  StackTrace stackTrace)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that.message,_that.cause);case CancelledFailure() when cancelled != null:
return cancelled();case HttpFailure() when http != null:
return http(_that.statusCode,_that.message,_that.responseBody);case ParseFailure() when parse != null:
return parse(_that.message,_that.stackTrace);case UnknownFailure() when unknown != null:
return unknown(_that.error,_that.stackTrace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message,  Object? cause)  network,required TResult Function()  cancelled,required TResult Function( int statusCode,  String message,  Object? responseBody)  http,required TResult Function( Object message,  StackTrace? stackTrace)  parse,required TResult Function( Object error,  StackTrace stackTrace)  unknown,}) {final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that.message,_that.cause);case CancelledFailure():
return cancelled();case HttpFailure():
return http(_that.statusCode,_that.message,_that.responseBody);case ParseFailure():
return parse(_that.message,_that.stackTrace);case UnknownFailure():
return unknown(_that.error,_that.stackTrace);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message,  Object? cause)?  network,TResult? Function()?  cancelled,TResult? Function( int statusCode,  String message,  Object? responseBody)?  http,TResult? Function( Object message,  StackTrace? stackTrace)?  parse,TResult? Function( Object error,  StackTrace stackTrace)?  unknown,}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that.message,_that.cause);case CancelledFailure() when cancelled != null:
return cancelled();case HttpFailure() when http != null:
return http(_that.statusCode,_that.message,_that.responseBody);case ParseFailure() when parse != null:
return parse(_that.message,_that.stackTrace);case UnknownFailure() when unknown != null:
return unknown(_that.error,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class NetworkFailure extends ApiFailure {
  const NetworkFailure(this.message, {this.cause}): super._();
  

 final  String message;
 final  Object? cause;

/// Create a copy of ApiFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkFailureCopyWith<NetworkFailure> get copyWith => _$NetworkFailureCopyWithImpl<NetworkFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(cause));

@override
String toString() {
  return 'ApiFailure.network(message: $message, cause: $cause)';
}


}

/// @nodoc
abstract mixin class $NetworkFailureCopyWith<$Res> implements $ApiFailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(NetworkFailure value, $Res Function(NetworkFailure) _then) = _$NetworkFailureCopyWithImpl;
@useResult
$Res call({
 String message, Object? cause
});




}
/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(this._self, this._then);

  final NetworkFailure _self;
  final $Res Function(NetworkFailure) _then;

/// Create a copy of ApiFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? cause = freezed,}) {
  return _then(NetworkFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause ,
  ));
}


}

/// @nodoc


class CancelledFailure extends ApiFailure {
  const CancelledFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelledFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiFailure.cancelled()';
}


}




/// @nodoc


class HttpFailure extends ApiFailure {
  const HttpFailure({required this.statusCode, required this.message, this.responseBody}): super._();
  

 final  int statusCode;
 final  String message;
 final  Object? responseBody;

/// Create a copy of ApiFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HttpFailureCopyWith<HttpFailure> get copyWith => _$HttpFailureCopyWithImpl<HttpFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HttpFailure&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.responseBody, responseBody));
}


@override
int get hashCode => Object.hash(runtimeType,statusCode,message,const DeepCollectionEquality().hash(responseBody));

@override
String toString() {
  return 'ApiFailure.http(statusCode: $statusCode, message: $message, responseBody: $responseBody)';
}


}

/// @nodoc
abstract mixin class $HttpFailureCopyWith<$Res> implements $ApiFailureCopyWith<$Res> {
  factory $HttpFailureCopyWith(HttpFailure value, $Res Function(HttpFailure) _then) = _$HttpFailureCopyWithImpl;
@useResult
$Res call({
 int statusCode, String message, Object? responseBody
});




}
/// @nodoc
class _$HttpFailureCopyWithImpl<$Res>
    implements $HttpFailureCopyWith<$Res> {
  _$HttpFailureCopyWithImpl(this._self, this._then);

  final HttpFailure _self;
  final $Res Function(HttpFailure) _then;

/// Create a copy of ApiFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? statusCode = null,Object? message = null,Object? responseBody = freezed,}) {
  return _then(HttpFailure(
statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,responseBody: freezed == responseBody ? _self.responseBody : responseBody ,
  ));
}


}

/// @nodoc


class ParseFailure extends ApiFailure {
  const ParseFailure(this.message, this.stackTrace): super._();
  

 final  Object message;
 final  StackTrace? stackTrace;

/// Create a copy of ApiFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseFailureCopyWith<ParseFailure> get copyWith => _$ParseFailureCopyWithImpl<ParseFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseFailure&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(message),stackTrace);

@override
String toString() {
  return 'ApiFailure.parse(message: $message, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $ParseFailureCopyWith<$Res> implements $ApiFailureCopyWith<$Res> {
  factory $ParseFailureCopyWith(ParseFailure value, $Res Function(ParseFailure) _then) = _$ParseFailureCopyWithImpl;
@useResult
$Res call({
 Object message, StackTrace? stackTrace
});




}
/// @nodoc
class _$ParseFailureCopyWithImpl<$Res>
    implements $ParseFailureCopyWith<$Res> {
  _$ParseFailureCopyWithImpl(this._self, this._then);

  final ParseFailure _self;
  final $Res Function(ParseFailure) _then;

/// Create a copy of ApiFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? stackTrace = freezed,}) {
  return _then(ParseFailure(
null == message ? _self.message : message ,freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class UnknownFailure extends ApiFailure {
  const UnknownFailure(this.error, this.stackTrace): super._();
  

 final  Object error;
 final  StackTrace stackTrace;

/// Create a copy of ApiFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownFailureCopyWith<UnknownFailure> get copyWith => _$UnknownFailureCopyWithImpl<UnknownFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownFailure&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error),stackTrace);

@override
String toString() {
  return 'ApiFailure.unknown(error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $UnknownFailureCopyWith<$Res> implements $ApiFailureCopyWith<$Res> {
  factory $UnknownFailureCopyWith(UnknownFailure value, $Res Function(UnknownFailure) _then) = _$UnknownFailureCopyWithImpl;
@useResult
$Res call({
 Object error, StackTrace stackTrace
});




}
/// @nodoc
class _$UnknownFailureCopyWithImpl<$Res>
    implements $UnknownFailureCopyWith<$Res> {
  _$UnknownFailureCopyWithImpl(this._self, this._then);

  final UnknownFailure _self;
  final $Res Function(UnknownFailure) _then;

/// Create a copy of ApiFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,Object? stackTrace = null,}) {
  return _then(UnknownFailure(
null == error ? _self.error : error ,null == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace,
  ));
}


}

// dart format on
