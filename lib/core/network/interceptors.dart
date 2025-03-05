import 'package:dio/dio.dart';

enum HeaderContentType { formType, jsonType, filetype }

class HeaderInterceptor extends Interceptor {
  HeaderInterceptor(
      {required this.dio, this.contentType = HeaderContentType.jsonType});

  final HeaderContentType contentType;
  final Dio dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Content-Type'] = contentType == HeaderContentType.jsonType
        ? 'application/json'
        : 'multipart/form-data';
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler, {
    bool Function(String token)? isExpired,
  }) async {
    super.onError(err, handler);
  }
}
