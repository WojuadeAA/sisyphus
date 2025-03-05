// ignore_for_file: avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sisyphus/core/constants/endpoints.dart';

import 'interceptors.dart';

final networkClientProvider = Provider<HttpClient>(
  (ref) => IHttpClient(
    baseUrl: Endpoints.baseUrl,
  ),
);

abstract class HttpClient {
  Future<Response<dynamic>> get(
    String url, {
    CancelToken cancelToken,
    Map<String, String>? queryParameters,
  });

  Future<Response<dynamic>> post(
    String url, {
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  });

  Future<Response<dynamic>> patch(
    String url, {
    Map<String, dynamic>? queryParameters,
    Object? body,
  });

  Future<Response<dynamic>> put(
    String url, {
    Map<String, dynamic>? queryParameters,
    Object? data,
  });

  Future<Response<dynamic>> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    Object? body,
  });
}

class IHttpClient implements HttpClient {
  IHttpClient({
    required this.baseUrl,
    this.receiveTimeout,
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 6),
        receiveTimeout: receiveTimeout ?? const Duration(seconds: 6),
      ),
    );
    _interceptorsInit();
  }

  @visibleForTesting
  late Dio dio;
  final String baseUrl;

  final Duration? receiveTimeout;
  static const int timeoutDuration = 1;

  void _interceptorsInit() {
    dio.interceptors.add(
      HeaderInterceptor(dio: dio),
    );
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
        ),
      );
    }
  }

  @override
  Future<Response<dynamic>> get(
    String urlEndPoint, {
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio
        .get<dynamic>(
          urlEndPoint,
          cancelToken: cancelToken,
          queryParameters: queryParameters,
        )
        .timeout(
          const Duration(minutes: timeoutDuration),
        );
  }

  @override
  Future<Response<dynamic>> post(
    String urlEndpoint, {
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return dio
        .post<dynamic>(
          urlEndpoint,
          data: body,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        )
        .timeout(
          const Duration(
            minutes: timeoutDuration,
          ),
        );
  }

  @override
  Future<Response<dynamic>> put(
    String urlEndpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return dio
        .put<dynamic>(
          urlEndpoint,
          data: data,
          queryParameters: queryParameters,
        )
        .timeout(const Duration(minutes: timeoutDuration));
  }

  @override
  Future<Response<dynamic>> delete(
    String url, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return dio
        .delete<dynamic>(url, data: body, queryParameters: queryParameters)
        .timeout(const Duration(minutes: timeoutDuration));
  }

  @override
  Future<Response<dynamic>> patch(
    String url, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return dio
        .patch<dynamic>(url, data: body, queryParameters: queryParameters)
        .timeout(const Duration(minutes: timeoutDuration));
  }
}

extension ResponseExt on Response<dynamic> {
  bool get isSuccessful => statusCode! >= 200 && statusCode! < 300;
  dynamic get body => data;
}

// Error Handler Function
String? networkErrorHandler(
  DioException error, {
  String? Function(DioException e)? onResponseError,
}) {
  const errorDefaultMessage = 'An Error Occurred';
  const tryAgain = 'Kindly Try Again';
  const requestCancelled = 'Request Cancelled';
  switch (error.type) {
    case DioExceptionType.badResponse:
      if (onResponseError == null && error.response != null) {
        if (error.response?.statusCode == 500) {
          return error.response!.data['message'] as String?;
        }
        if (error.response!.statusCode == 400) {
          if (error.response!.data['message'] is List) {
            final errorList = error.response?.data['message'] as List<String?>;
            return errorList.join(', ');
          }
          return error.response?.data['message'].toString();
        }
        return error.response?.data['message'] as String?;
      }
      return onResponseError!(error);
    case DioExceptionType.sendTimeout:
      return tryAgain;
    case DioExceptionType.receiveTimeout:
      return tryAgain;
    case DioExceptionType.cancel:
      return requestCancelled;
    case DioExceptionType.connectionTimeout:
      return errorDefaultMessage;
    case DioExceptionType.badCertificate:
      return errorDefaultMessage;
    case DioExceptionType.connectionError:
      return errorDefaultMessage;
    case DioExceptionType.unknown:
      if (onResponseError == null && error.response != null) {
        if (error.response?.statusCode == 500) {
          return error.response!.data['message'] as String?;
        }
        if (error.response!.statusCode == 400) {
          if (error.response!.data['message'] is List) {
            final errorList = error.response?.data['message'] as List<String?>;
            return errorList.join(', ');
          }
          return error.response?.data['message'].toString();
        }
        return error.response?.data['message'] as String?;
      }
      return onResponseError!(error);
  }
}
