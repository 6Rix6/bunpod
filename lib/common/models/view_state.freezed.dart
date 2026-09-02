// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
ViewState<T> _$ViewStateFromJson<T>(
  Map<String, dynamic> json,T Function(Object?) fromJsonT
) {
        switch (json['runtimeType']) {
                  case 'idle':
          return ViewIdle<T>.fromJson(
            json,fromJsonT
          );
                case 'busy':
          return ViewBusy<T>.fromJson(
            json,fromJsonT
          );
                case 'ready':
          return ViewReady<T>.fromJson(
            json,fromJsonT
          );
                case 'failed':
          return ViewFailed<T>.fromJson(
            json,fromJsonT
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'ViewState',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$ViewState<T> {



  /// Serializes this ViewState to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ViewState<T>);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ViewState<$T>()';
}


}

/// @nodoc
class $ViewStateCopyWith<T,$Res>  {
$ViewStateCopyWith(ViewState<T> _, $Res Function(ViewState<T>) __);
}


/// Adds pattern-matching-related methods to [ViewState].
extension ViewStatePatterns<T> on ViewState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ViewIdle<T> value)?  idle,TResult Function( ViewBusy<T> value)?  busy,TResult Function( ViewReady<T> value)?  ready,TResult Function( ViewFailed<T> value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ViewIdle() when idle != null:
return idle(_that);case ViewBusy() when busy != null:
return busy(_that);case ViewReady() when ready != null:
return ready(_that);case ViewFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ViewIdle<T> value)  idle,required TResult Function( ViewBusy<T> value)  busy,required TResult Function( ViewReady<T> value)  ready,required TResult Function( ViewFailed<T> value)  failed,}){
final _that = this;
switch (_that) {
case ViewIdle():
return idle(_that);case ViewBusy():
return busy(_that);case ViewReady():
return ready(_that);case ViewFailed():
return failed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ViewIdle<T> value)?  idle,TResult? Function( ViewBusy<T> value)?  busy,TResult? Function( ViewReady<T> value)?  ready,TResult? Function( ViewFailed<T> value)?  failed,}){
final _that = this;
switch (_that) {
case ViewIdle() when idle != null:
return idle(_that);case ViewBusy() when busy != null:
return busy(_that);case ViewReady() when ready != null:
return ready(_that);case ViewFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( T? data)?  busy,TResult Function( T data)?  ready,TResult Function( AppError? error,  T? previousData)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ViewIdle() when idle != null:
return idle();case ViewBusy() when busy != null:
return busy(_that.data);case ViewReady() when ready != null:
return ready(_that.data);case ViewFailed() when failed != null:
return failed(_that.error,_that.previousData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( T? data)  busy,required TResult Function( T data)  ready,required TResult Function( AppError? error,  T? previousData)  failed,}) {final _that = this;
switch (_that) {
case ViewIdle():
return idle();case ViewBusy():
return busy(_that.data);case ViewReady():
return ready(_that.data);case ViewFailed():
return failed(_that.error,_that.previousData);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( T? data)?  busy,TResult? Function( T data)?  ready,TResult? Function( AppError? error,  T? previousData)?  failed,}) {final _that = this;
switch (_that) {
case ViewIdle() when idle != null:
return idle();case ViewBusy() when busy != null:
return busy(_that.data);case ViewReady() when ready != null:
return ready(_that.data);case ViewFailed() when failed != null:
return failed(_that.error,_that.previousData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class ViewIdle<T> extends ViewState<T> {
  const ViewIdle({ String? $type}): $type = $type ?? 'idle',super._();
  factory ViewIdle.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$ViewIdleFromJson(json,fromJsonT);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$ViewIdleToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ViewIdle<T>);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ViewState<$T>.idle()';
}


}




/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class ViewBusy<T> extends ViewState<T> {
  const ViewBusy([this.data,  String? $type]): $type = $type ?? 'busy',super._();
  factory ViewBusy.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$ViewBusyFromJson(json,fromJsonT);

 final  T? data;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ViewBusyCopyWith<T, ViewBusy<T>> get copyWith => _$ViewBusyCopyWithImpl<T, ViewBusy<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$ViewBusyToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ViewBusy<T>&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ViewState<$T>.busy(data: $data)';
}


}

/// @nodoc
abstract mixin class $ViewBusyCopyWith<T,$Res> implements $ViewStateCopyWith<T, $Res> {
  factory $ViewBusyCopyWith(ViewBusy<T> value, $Res Function(ViewBusy<T>) _then) = _$ViewBusyCopyWithImpl;
@useResult
$Res call({
 T? data
});




}
/// @nodoc
class _$ViewBusyCopyWithImpl<T,$Res>
    implements $ViewBusyCopyWith<T, $Res> {
  _$ViewBusyCopyWithImpl(this._self, this._then);

  final ViewBusy<T> _self;
  final $Res Function(ViewBusy<T>) _then;

/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(ViewBusy<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}


}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class ViewReady<T> extends ViewState<T> {
  const ViewReady(this.data, { String? $type}): $type = $type ?? 'ready',super._();
  factory ViewReady.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$ViewReadyFromJson(json,fromJsonT);

 final  T data;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ViewReadyCopyWith<T, ViewReady<T>> get copyWith => _$ViewReadyCopyWithImpl<T, ViewReady<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$ViewReadyToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ViewReady<T>&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ViewState<$T>.ready(data: $data)';
}


}

/// @nodoc
abstract mixin class $ViewReadyCopyWith<T,$Res> implements $ViewStateCopyWith<T, $Res> {
  factory $ViewReadyCopyWith(ViewReady<T> value, $Res Function(ViewReady<T>) _then) = _$ViewReadyCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$ViewReadyCopyWithImpl<T,$Res>
    implements $ViewReadyCopyWith<T, $Res> {
  _$ViewReadyCopyWithImpl(this._self, this._then);

  final ViewReady<T> _self;
  final $Res Function(ViewReady<T>) _then;

/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(ViewReady<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class ViewFailed<T> extends ViewState<T> {
  const ViewFailed([this.error, this.previousData,  String? $type]): $type = $type ?? 'failed',super._();
  factory ViewFailed.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$ViewFailedFromJson(json,fromJsonT);

 final  AppError? error;
 final  T? previousData;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ViewFailedCopyWith<T, ViewFailed<T>> get copyWith => _$ViewFailedCopyWithImpl<T, ViewFailed<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$ViewFailedToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ViewFailed<T>&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.previousData, previousData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error,const DeepCollectionEquality().hash(previousData));

@override
String toString() {
  return 'ViewState<$T>.failed(error: $error, previousData: $previousData)';
}


}

/// @nodoc
abstract mixin class $ViewFailedCopyWith<T,$Res> implements $ViewStateCopyWith<T, $Res> {
  factory $ViewFailedCopyWith(ViewFailed<T> value, $Res Function(ViewFailed<T>) _then) = _$ViewFailedCopyWithImpl;
@useResult
$Res call({
 AppError? error, T? previousData
});


$AppErrorCopyWith<$Res>? get error;

}
/// @nodoc
class _$ViewFailedCopyWithImpl<T,$Res>
    implements $ViewFailedCopyWith<T, $Res> {
  _$ViewFailedCopyWithImpl(this._self, this._then);

  final ViewFailed<T> _self;
  final $Res Function(ViewFailed<T>) _then;

/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = freezed,Object? previousData = freezed,}) {
  return _then(ViewFailed<T>(
freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppError?,freezed == previousData ? _self.previousData : previousData // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}

/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $AppErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

// dart format on
