import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptors extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          '--> ${options.method.toUpperCase()} ${options.baseUrl}${options.path}');
      print('Headers:');
      options.headers.forEach((k, v) {
        if (kDebugMode) {
          return print('$k: $v');
        }
      });
      print('queryParameters:');
      options.queryParameters.forEach((k, v) {
        if (kDebugMode) {
          return print('$k: $v');
        }
      });

      if (options.data != null) {
        print('Body: ${options.data}');
      }
      print('--> END ${options.method.toUpperCase()}');
    }
    // return options;
    handler.next(options);
  }

  @override
  FutureOr<dynamic> onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          "<-- ${err.message} ${(err.response?.requestOptions != null ? ('${err.response?.requestOptions.baseUrl} ${err.response!.requestOptions.path}') : 'URL')}");
      print("${err.response != null ? err.response?.data : 'Unknown Error'}");
      print('<-- End error');
    }
    handler.next(err);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          "<-- ${response.statusCode} '${response.requestOptions.baseUrl} ${response.requestOptions.path}'");
      print('Headers:');
      response.headers.forEach((k, v) {
        if (kDebugMode) {
          return print('$k: $v');
        }
      });
      print('Response: ${response.data}');
      print('<-- END HTTP');
    }
    handler.next(response);
  }
}
