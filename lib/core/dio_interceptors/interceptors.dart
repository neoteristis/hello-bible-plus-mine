import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../base_repository/base_repository.dart';
import '../db_services/db_services.dart';
import '../entities/token.dart';

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

class AppInterceptors extends Interceptor {
  final BaseRepository baseRepo;
  final DbService db;
  final Dio dio;

  AppInterceptors({
    required this.baseRepo,
    required this.db,
    required this.dio,
  });

  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra['add_token'] == true) {
      final String? jwt = await db.getToken();
      Logger().w(jwt);
      if (jwt != null) {
        options.headers['Authorization'] = 'Bearer $jwt';
      }
    }
    handler.next(options);
  }

  @override
  FutureOr<dynamic> onError(
      DioError err, ErrorInterceptorHandler handler) async {
    final RequestOptions origin = err.requestOptions;
    if (err.response?.statusCode == 401) {
      final String? refreshToken = await db.getRefreshToken();
      Logger().i(refreshToken);
      if (refreshToken != null) {
        try {
          final res = await baseRepo.post(
            '/auth/token/refresh',
            body: {
              'refresh_token': refreshToken,
            },
            addToken: false,
          );
          if (res.statusCode == 200) {
            final response = Token.fromJson(res.data);
            await db.saveToken(response);
            origin.headers['Authorization'] = 'Bearer ${response.token}';
            return dio.request(
              origin.path,
              data: origin.data,
              options: Options(
                method: origin.method,
                sendTimeout: origin.sendTimeout,
                receiveTimeout: origin.receiveTimeout,
                extra: origin.extra,
                headers: origin.headers,
                responseType: origin.responseType,
                contentType: origin.contentType,
                validateStatus: origin.validateStatus,
                receiveDataWhenStatusError: origin.receiveDataWhenStatusError,
                followRedirects: origin.followRedirects,
                maxRedirects: origin.maxRedirects,
                requestEncoder: origin.requestEncoder,
                responseDecoder: origin.responseDecoder,
                listFormat: origin.listFormat,
              ),
            );
          }
        } catch (err) {
          return err;
        }
      }
    }
    handler.next(err);
  }

  @override
  FutureOr<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }
}
