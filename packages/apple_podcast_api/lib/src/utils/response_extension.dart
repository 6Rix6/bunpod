import 'package:dio/dio.dart';

extension ResponseDataCopy<T> on Response<T> {
  /// Creates a new [Response] with updated [data] and optional [R] type.
  /// All other response fields are copied from the original instance.
  Response<R> copyWithData<R>(R? newData) {
    return Response<R>(
      data: newData,
      requestOptions: requestOptions,
      statusCode: statusCode,
      statusMessage: statusMessage,
      isRedirect: isRedirect,
      redirects: redirects,
      extra: Map<String, dynamic>.from(extra),
      headers: headers,
    );
  }
}
