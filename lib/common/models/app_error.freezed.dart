// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppError {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppError()';
}


}

/// @nodoc
class $AppErrorCopyWith<$Res>  {
$AppErrorCopyWith(AppError _, $Res Function(AppError) __);
}


/// Adds pattern-matching-related methods to [AppError].
extension AppErrorPatterns on AppError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NetworkError value)?  network,TResult Function( CancelledError value)?  cancelled,TResult Function( HttpError value)?  http,TResult Function( ParseError value)?  parse,TResult Function( CacheError value)?  cache,TResult Function( MultipleError value)?  multiple,TResult Function( UnknownError value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NetworkError() when network != null:
return network(_that);case CancelledError() when cancelled != null:
return cancelled(_that);case HttpError() when http != null:
return http(_that);case ParseError() when parse != null:
return parse(_that);case CacheError() when cache != null:
return cache(_that);case MultipleError() when multiple != null:
return multiple(_that);case UnknownError() when unknown != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NetworkError value)  network,required TResult Function( CancelledError value)  cancelled,required TResult Function( HttpError value)  http,required TResult Function( ParseError value)  parse,required TResult Function( CacheError value)  cache,required TResult Function( MultipleError value)  multiple,required TResult Function( UnknownError value)  unknown,}){
final _that = this;
switch (_that) {
case NetworkError():
return network(_that);case CancelledError():
return cancelled(_that);case HttpError():
return http(_that);case ParseError():
return parse(_that);case CacheError():
return cache(_that);case MultipleError():
return multiple(_that);case UnknownError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NetworkError value)?  network,TResult? Function( CancelledError value)?  cancelled,TResult? Function( HttpError value)?  http,TResult? Function( ParseError value)?  parse,TResult? Function( CacheError value)?  cache,TResult? Function( MultipleError value)?  multiple,TResult? Function( UnknownError value)?  unknown,}){
final _that = this;
switch (_that) {
case NetworkError() when network != null:
return network(_that);case CancelledError() when cancelled != null:
return cancelled(_that);case HttpError() when http != null:
return http(_that);case ParseError() when parse != null:
return parse(_that);case CacheError() when cache != null:
return cache(_that);case MultipleError() when multiple != null:
return multiple(_that);case UnknownError() when unknown != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message,  Object? cause)?  network,TResult Function()?  cancelled,TResult Function( int statusCode,  String message,  Object? responseBody)?  http,TResult Function( Object message,  StackTrace? stackTrace)?  parse,TResult Function( String message)?  cache,TResult Function( List<AppError> errors)?  multiple,TResult Function( Object error,  StackTrace stackTrace)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NetworkError() when network != null:
return network(_that.message,_that.cause);case CancelledError() when cancelled != null:
return cancelled();case HttpError() when http != null:
return http(_that.statusCode,_that.message,_that.responseBody);case ParseError() when parse != null:
return parse(_that.message,_that.stackTrace);case CacheError() when cache != null:
return cache(_that.message);case MultipleError() when multiple != null:
return multiple(_that.errors);case UnknownError() when unknown != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message,  Object? cause)  network,required TResult Function()  cancelled,required TResult Function( int statusCode,  String message,  Object? responseBody)  http,required TResult Function( Object message,  StackTrace? stackTrace)  parse,required TResult Function( String message)  cache,required TResult Function( List<AppError> errors)  multiple,required TResult Function( Object error,  StackTrace stackTrace)  unknown,}) {final _that = this;
switch (_that) {
case NetworkError():
return network(_that.message,_that.cause);case CancelledError():
return cancelled();case HttpError():
return http(_that.statusCode,_that.message,_that.responseBody);case ParseError():
return parse(_that.message,_that.stackTrace);case CacheError():
return cache(_that.message);case MultipleError():
return multiple(_that.errors);case UnknownError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message,  Object? cause)?  network,TResult? Function()?  cancelled,TResult? Function( int statusCode,  String message,  Object? responseBody)?  http,TResult? Function( Object message,  StackTrace? stackTrace)?  parse,TResult? Function( String message)?  cache,TResult? Function( List<AppError> errors)?  multiple,TResult? Function( Object error,  StackTrace stackTrace)?  unknown,}) {final _that = this;
switch (_that) {
case NetworkError() when network != null:
return network(_that.message,_that.cause);case CancelledError() when cancelled != null:
return cancelled();case HttpError() when http != null:
return http(_that.statusCode,_that.message,_that.responseBody);case ParseError() when parse != null:
return parse(_that.message,_that.stackTrace);case CacheError() when cache != null:
return cache(_that.message);case MultipleError() when multiple != null:
return multiple(_that.errors);case UnknownError() when unknown != null:
return unknown(_that.error,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class NetworkError implements AppError {
  const NetworkError(this.message, {this.cause});
  

 final  String message;
 final  Object? cause;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkErrorCopyWith<NetworkError> get copyWith => _$NetworkErrorCopyWithImpl<NetworkError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkError&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(cause));

@override
String toString() {
  return 'AppError.network(message: $message, cause: $cause)';
}


}

/// @nodoc
abstract mixin class $NetworkErrorCopyWith<$Res> implements $AppErrorCopyWith<$Res> {
  factory $NetworkErrorCopyWith(NetworkError value, $Res Function(NetworkError) _then) = _$NetworkErrorCopyWithImpl;
@useResult
$Res call({
 String message, Object? cause
});




}
/// @nodoc
class _$NetworkErrorCopyWithImpl<$Res>
    implements $NetworkErrorCopyWith<$Res> {
  _$NetworkErrorCopyWithImpl(this._self, this._then);

  final NetworkError _self;
  final $Res Function(NetworkError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? cause = freezed,}) {
  return _then(NetworkError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause ,
  ));
}


}

/// @nodoc


class CancelledError implements AppError {
  const CancelledError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelledError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppError.cancelled()';
}


}




/// @nodoc


class HttpError implements AppError {
  const HttpError({required this.statusCode, required this.message, this.responseBody});
  

 final  int statusCode;
 final  String message;
 final  Object? responseBody;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HttpErrorCopyWith<HttpError> get copyWith => _$HttpErrorCopyWithImpl<HttpError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HttpError&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.responseBody, responseBody));
}


@override
int get hashCode => Object.hash(runtimeType,statusCode,message,const DeepCollectionEquality().hash(responseBody));

@override
String toString() {
  return 'AppError.http(statusCode: $statusCode, message: $message, responseBody: $responseBody)';
}


}

/// @nodoc
abstract mixin class $HttpErrorCopyWith<$Res> implements $AppErrorCopyWith<$Res> {
  factory $HttpErrorCopyWith(HttpError value, $Res Function(HttpError) _then) = _$HttpErrorCopyWithImpl;
@useResult
$Res call({
 int statusCode, String message, Object? responseBody
});




}
/// @nodoc
class _$HttpErrorCopyWithImpl<$Res>
    implements $HttpErrorCopyWith<$Res> {
  _$HttpErrorCopyWithImpl(this._self, this._then);

  final HttpError _self;
  final $Res Function(HttpError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? statusCode = null,Object? message = null,Object? responseBody = freezed,}) {
  return _then(HttpError(
statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,responseBody: freezed == responseBody ? _self.responseBody : responseBody ,
  ));
}


}

/// @nodoc


class ParseError implements AppError {
  const ParseError(this.message, this.stackTrace);
  

 final  Object message;
 final  StackTrace? stackTrace;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseErrorCopyWith<ParseError> get copyWith => _$ParseErrorCopyWithImpl<ParseError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseError&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(message),stackTrace);

@override
String toString() {
  return 'AppError.parse(message: $message, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $ParseErrorCopyWith<$Res> implements $AppErrorCopyWith<$Res> {
  factory $ParseErrorCopyWith(ParseError value, $Res Function(ParseError) _then) = _$ParseErrorCopyWithImpl;
@useResult
$Res call({
 Object message, StackTrace? stackTrace
});




}
/// @nodoc
class _$ParseErrorCopyWithImpl<$Res>
    implements $ParseErrorCopyWith<$Res> {
  _$ParseErrorCopyWithImpl(this._self, this._then);

  final ParseError _self;
  final $Res Function(ParseError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? stackTrace = freezed,}) {
  return _then(ParseError(
null == message ? _self.message : message ,freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class CacheError implements AppError {
  const CacheError(this.message);
  

 final  String message;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CacheErrorCopyWith<CacheError> get copyWith => _$CacheErrorCopyWithImpl<CacheError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppError.cache(message: $message)';
}


}

/// @nodoc
abstract mixin class $CacheErrorCopyWith<$Res> implements $AppErrorCopyWith<$Res> {
  factory $CacheErrorCopyWith(CacheError value, $Res Function(CacheError) _then) = _$CacheErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CacheErrorCopyWithImpl<$Res>
    implements $CacheErrorCopyWith<$Res> {
  _$CacheErrorCopyWithImpl(this._self, this._then);

  final CacheError _self;
  final $Res Function(CacheError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CacheError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MultipleError implements AppError {
  const MultipleError( List<AppError> errors): _errors = errors;
  

 final  List<AppError> _errors;
 List<AppError> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}


/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MultipleErrorCopyWith<MultipleError> get copyWith => _$MultipleErrorCopyWithImpl<MultipleError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MultipleError&&const DeepCollectionEquality().equals(other._errors, _errors));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'AppError.multiple(errors: $errors)';
}


}

/// @nodoc
abstract mixin class $MultipleErrorCopyWith<$Res> implements $AppErrorCopyWith<$Res> {
  factory $MultipleErrorCopyWith(MultipleError value, $Res Function(MultipleError) _then) = _$MultipleErrorCopyWithImpl;
@useResult
$Res call({
 List<AppError> errors
});




}
/// @nodoc
class _$MultipleErrorCopyWithImpl<$Res>
    implements $MultipleErrorCopyWith<$Res> {
  _$MultipleErrorCopyWithImpl(this._self, this._then);

  final MultipleError _self;
  final $Res Function(MultipleError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errors = null,}) {
  return _then(MultipleError(
null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<AppError>,
  ));
}


}

/// @nodoc


class UnknownError implements AppError {
  const UnknownError(this.error, this.stackTrace);
  

 final  Object error;
 final  StackTrace stackTrace;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownErrorCopyWith<UnknownError> get copyWith => _$UnknownErrorCopyWithImpl<UnknownError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownError&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error),stackTrace);

@override
String toString() {
  return 'AppError.unknown(error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $UnknownErrorCopyWith<$Res> implements $AppErrorCopyWith<$Res> {
  factory $UnknownErrorCopyWith(UnknownError value, $Res Function(UnknownError) _then) = _$UnknownErrorCopyWithImpl;
@useResult
$Res call({
 Object error, StackTrace stackTrace
});




}
/// @nodoc
class _$UnknownErrorCopyWithImpl<$Res>
    implements $UnknownErrorCopyWith<$Res> {
  _$UnknownErrorCopyWithImpl(this._self, this._then);

  final UnknownError _self;
  final $Res Function(UnknownError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,Object? stackTrace = null,}) {
  return _then(UnknownError(
null == error ? _self.error : error ,null == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace,
  ));
}


}

// dart format on
