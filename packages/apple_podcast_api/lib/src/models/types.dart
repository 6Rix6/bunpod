import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:fpdart/fpdart.dart';

/// Result of an API call: either an [ApiFailure] or the parsed value.
typedef ApiResult<T> = Future<Either<ApiFailure, T>>;
