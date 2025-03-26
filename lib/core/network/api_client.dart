import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode

class ApiClient {

  late final Dio dio;

  ApiClient() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com/',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),);

    // Add debug-only logging
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => print('DEBUG LOG: $obj'),
        ),
      );
    }

    // Add the full interceptor (with onRequest, onResponse, onError)
    dio.interceptors.add(_fullInterceptor());
  }

  InterceptorsWrapper _fullInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        const token = 'your_access_token';
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },

      // RESPONSE INTERCEPTOR (works in debug and release unless you wrap in kDebugMode)
      onResponse: (response, handler) {
        if (kDebugMode) {
          print(' Response Interceptor (Debug): ${response.statusCode}');
        }
        handler.next(response);
      },

      onError: (DioException e, handler) {
        if (kDebugMode) {
          print(' API Error (Debug): ${e.message}');
        }
        handler.next(e);
      },
    );
  }

}
