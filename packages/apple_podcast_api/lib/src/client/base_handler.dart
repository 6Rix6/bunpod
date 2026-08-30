import 'package:apple_podcast_api/src/models/api_failure.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

typedef HandlerTask<T> = TaskEither<ApiFailure, Response<T>>;

class BaseHandler {
  final Dio _httpClient;
  String? _baseUrl;

  BaseHandler({String? baseUrl, Dio? httpClient})
    : _baseUrl = baseUrl,
      _httpClient = httpClient ?? Dio() {
    if (baseUrl != null) {
      _httpClient.options.baseUrl = baseUrl;
    }
  }

  String? get baseUrl => _baseUrl;
  Dio get httpClient => _httpClient;

  set baseUrl(String value) {
    _baseUrl = value;
    _httpClient.options.baseUrl = value;
  }

  Future<Response<T>> _withRetry<T>(
    Future<Response<T>> Function() block, {
    int maxAttempts = 3,
    Duration initialDelay = const Duration(milliseconds: 500),
    double factor = 2.0,
  }) async {
    var currentDelay = initialDelay;
    var attempt = 0;
    while (true) {
      try {
        return await block();
      } on DioException catch (e) {
        final retryable =
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.connectionError;
        attempt++;
        if (!retryable || attempt >= maxAttempts) rethrow;
        await Future.delayed(currentDelay);
        currentDelay = Duration(
          milliseconds: (currentDelay.inMilliseconds * factor).toInt(),
        );
      }
    }
  }

  HandlerTask<T> _task<T>(Future<Response<T>> Function() block) {
    return TaskEither.tryCatch(() => _withRetry(block), _mapDioErrorToFailure);
  }

  ApiFailure _mapDioErrorToFailure(Object error, StackTrace stackTrace) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
          return NetworkFailure(
            error.message ?? 'Connection error',
            cause: error,
          );
        case DioExceptionType.cancel:
          return const CancelledFailure();
        case DioExceptionType.badResponse:
          final response = error.response;
          return HttpFailure(
            statusCode: response?.statusCode ?? -1,
            message: error.message ?? 'Bad response',
            responseBody: response?.data,
          );

        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
        default:
          return UnknownFailure(error, stackTrace);
      }
    }
    return UnknownFailure(error, stackTrace);
  }

  // The iTunes Search API only accepts GET requests; all query parameters
  // are built by the caller (ItunesPodcastApi).
  HandlerTask<dynamic> get(
    String path,
    Map<String, Object?> queryParameters, {
    Map<String, dynamic>? headers,
  }) {
    return _task(
      () => _httpClient.get<dynamic>(
        path,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      ),
    );
  }

  // Fetches a resource as raw text (used for RSS feeds). An absolute [url]
  // overrides the configured base URL.
  HandlerTask<String> getPlainText(Uri url, {Map<String, dynamic>? headers}) {
    return _task(
      () => _httpClient.get<String>(
        url.toString(),
        options: Options(responseType: ResponseType.plain, headers: headers),
      ),
    );
  }

  void close() => _httpClient.close();
}
