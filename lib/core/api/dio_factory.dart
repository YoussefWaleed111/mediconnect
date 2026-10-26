import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioFactory {
  DioFactory._();

  static Dio? _dio;
  static const Duration _timeout = Duration(seconds: 30);
  static const String baseUrl = 'https://api.mediconnect.com/api/v1/';

  static Dio getDio() {
    if (_dio == null) {
      final dio = Dio();

      dio.options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        sendTimeout: _timeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      _addInterceptors(dio);
      _dio = dio;
      return dio;
    }
    return _dio!;
  }

  static void _addInterceptors(Dio dio) {
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
        ),
      );
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onError: (DioException error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  static void setTokenIntoHeader(String token) {
    _dio?.options.headers['Authorization'] = 'Bearer $token';
  }

  static void clearTokenFromHeader() {
    _dio?.options.headers.remove('Authorization');
  }
}
