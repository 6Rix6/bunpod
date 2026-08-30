import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

typedef AppEither<T> = Either<AppError, T>;
typedef AppTaskEither<T> = TaskEither<AppError, T>;

@freezed
sealed class AppError with _$AppError {
  /// Connection could not be established or timed out.
  const factory AppError.network(
    String message, {
    Object? cause,
  }) = NetworkError;

  /// The request was cancelled before it completed.
  const factory AppError.cancelled() = CancelledError;

  /// The server responded with a non-success status code.
  const factory AppError.http({
    required int statusCode,
    required String message,
    Object? responseBody,
  }) = HttpError;

  /// A response was received but its body could not be parsed.
  const factory AppError.parse(
    Object message,
    StackTrace? stackTrace,
  ) = ParseError;

  const factory AppError.cache(String message) = CacheError;

  const factory AppError.multiple(List<AppError> errors) = MultipleError;

  /// Any unexpected error that does not fit the other categories.
  const factory AppError.unknown(
    Object error,
    StackTrace stackTrace,
  ) = UnknownError;
}
