import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';
part 'app_error.g.dart';

typedef AppEither<T> = Either<AppError, T>;
typedef AppTaskEither<T> = TaskEither<AppError, T>;

/// StackTrace? <-> String?
class StackTraceConverter implements JsonConverter<StackTrace?, String?> {
  const StackTraceConverter();

  @override
  StackTrace? fromJson(String? json) =>
      json == null ? null : StackTrace.fromString(json);

  @override
  String? toJson(StackTrace? object) => object?.toString();
}

/// StackTrace (non-null) <-> String
class RequiredStackTraceConverter
    implements JsonConverter<StackTrace, String> {
  const RequiredStackTraceConverter();

  @override
  StackTrace fromJson(String json) => StackTrace.fromString(json);

  @override
  String toJson(StackTrace object) => object.toString();
}

/// Object? <-> String?
class ObjectConverter implements JsonConverter<Object?, String?> {
  const ObjectConverter();

  @override
  Object? fromJson(String? json) => json;

  @override
  String? toJson(Object? object) => object?.toString();
}

/// Object (non-null) <-> String
class RequiredObjectConverter implements JsonConverter<Object, String> {
  const RequiredObjectConverter();

  @override
  Object fromJson(String json) => json;

  @override
  String toJson(Object object) => object.toString();
}

@freezed
sealed class AppError with _$AppError {
  /// Connection could not be established or timed out.
  const factory AppError.network(
    String message, {
    @ObjectConverter() Object? cause,
  }) = NetworkError;

  /// The request was cancelled before it completed.
  const factory AppError.cancelled() = CancelledError;

  /// The server responded with a non-success status code.
  const factory AppError.http({
    required int statusCode,
    required String message,
    @ObjectConverter() Object? responseBody,
  }) = HttpError;

  /// A response was received but its body could not be parsed.
  const factory AppError.parse(
    @RequiredObjectConverter() Object message,
    @StackTraceConverter() StackTrace? stackTrace,
  ) = ParseError;

  const factory AppError.cache(String message) = CacheError;

  const factory AppError.multiple(List<AppError> errors) = MultipleError;

  /// Any unexpected error that does not fit the other categories.
  const factory AppError.unknown(
    @RequiredObjectConverter() Object error,
    @RequiredStackTraceConverter() StackTrace stackTrace,
  ) = UnknownError;

  factory AppError.fromJson(Map<String, dynamic> json) =>
      _$AppErrorFromJson(json);
}
