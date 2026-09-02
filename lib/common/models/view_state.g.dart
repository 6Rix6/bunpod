// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewIdle<T> _$ViewIdleFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ViewIdle<T>($type: json['runtimeType'] as String?);

Map<String, dynamic> _$ViewIdleToJson<T>(
  ViewIdle<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{'runtimeType': instance.$type};

ViewBusy<T> _$ViewBusyFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ViewBusy<T>(
  _$nullableGenericFromJson(json['data'], fromJsonT),
  json['runtimeType'] as String?,
);

Map<String, dynamic> _$ViewBusyToJson<T>(
  ViewBusy<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'runtimeType': instance.$type,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

ViewReady<T> _$ViewReadyFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ViewReady<T>(
  fromJsonT(json['data']),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$ViewReadyToJson<T>(
  ViewReady<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'data': toJsonT(instance.data),
  'runtimeType': instance.$type,
};

ViewFailed<T> _$ViewFailedFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ViewFailed<T>(
  json['error'] == null
      ? null
      : AppError.fromJson(json['error'] as Map<String, dynamic>),
  _$nullableGenericFromJson(json['previousData'], fromJsonT),
  json['runtimeType'] as String?,
);

Map<String, dynamic> _$ViewFailedToJson<T>(
  ViewFailed<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'error': instance.error,
  'previousData': _$nullableGenericToJson(instance.previousData, toJsonT),
  'runtimeType': instance.$type,
};
