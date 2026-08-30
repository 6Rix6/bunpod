// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkError _$NetworkErrorFromJson(Map<String, dynamic> json) => NetworkError(
  json['message'] as String,
  cause: const ObjectConverter().fromJson(json['cause'] as String?),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$NetworkErrorToJson(NetworkError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'cause': const ObjectConverter().toJson(instance.cause),
      'runtimeType': instance.$type,
    };

CancelledError _$CancelledErrorFromJson(Map<String, dynamic> json) =>
    CancelledError($type: json['runtimeType'] as String?);

Map<String, dynamic> _$CancelledErrorToJson(CancelledError instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

HttpError _$HttpErrorFromJson(Map<String, dynamic> json) => HttpError(
  statusCode: (json['statusCode'] as num).toInt(),
  message: json['message'] as String,
  responseBody: const ObjectConverter().fromJson(
    json['responseBody'] as String?,
  ),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$HttpErrorToJson(HttpError instance) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'message': instance.message,
  'responseBody': const ObjectConverter().toJson(instance.responseBody),
  'runtimeType': instance.$type,
};

ParseError _$ParseErrorFromJson(Map<String, dynamic> json) => ParseError(
  const RequiredObjectConverter().fromJson(json['message'] as String),
  const StackTraceConverter().fromJson(json['stackTrace'] as String?),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$ParseErrorToJson(ParseError instance) =>
    <String, dynamic>{
      'message': const RequiredObjectConverter().toJson(instance.message),
      'stackTrace': const StackTraceConverter().toJson(instance.stackTrace),
      'runtimeType': instance.$type,
    };

CacheError _$CacheErrorFromJson(Map<String, dynamic> json) => CacheError(
  json['message'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$CacheErrorToJson(CacheError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'runtimeType': instance.$type,
    };

MultipleError _$MultipleErrorFromJson(Map<String, dynamic> json) =>
    MultipleError(
      (json['errors'] as List<dynamic>)
          .map((e) => AppError.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$MultipleErrorToJson(MultipleError instance) =>
    <String, dynamic>{'errors': instance.errors, 'runtimeType': instance.$type};

UnknownError _$UnknownErrorFromJson(Map<String, dynamic> json) => UnknownError(
  const RequiredObjectConverter().fromJson(json['error'] as String),
  const RequiredStackTraceConverter().fromJson(json['stackTrace'] as String),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$UnknownErrorToJson(
  UnknownError instance,
) => <String, dynamic>{
  'error': const RequiredObjectConverter().toJson(instance.error),
  'stackTrace': const RequiredStackTraceConverter().toJson(instance.stackTrace),
  'runtimeType': instance.$type,
};
