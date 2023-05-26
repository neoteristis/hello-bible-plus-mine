import 'dart:convert';
import 'package:dio/dio.dart';

import 'base_repository.dart';

class BaseRepositoryImp implements BaseRepository {
  BaseRepositoryImp({
    this.baseUrl,
    this.headers = const {
      'Content-Type': 'application/json',
    },
    required this.dio,
  });

  String? baseUrl;
  Map<String, String> headers;
  Dio dio;

  @override
  Future<Response> post(
    String? url, {
    dynamic body,
    Map<String, String>? headers,
    Encoding? encoding,
    bool? addToken,
  }) async {
    return await dio.post(
      url!,
      data: body,
      options: Options(
        headers: headers ?? this.headers,
        extra: {'add_token': addToken ?? true},
      ),
    );
  }

  @override
  Future<Response> get(
    String? url, {
    Map<String, String>? headers,
    bool? addToken,
    Options? options,
    // ResponseType? responseType,
  }) async {
    return await dio.get(
      url!,
      options: options ??
          Options(
            headers: headers ?? this.headers,
            extra: {'add_token': addToken ?? true},
          ),
    );
  }

  @override
  Future<Response> patch(
    String? url, {
    dynamic body,
    Map<String, String>? headers,
    Encoding? encoding,
    bool? addToken,
  }) async {
    return await dio.patch(
      url!,
      options: Options(
          headers: headers ?? this.headers,
          extra: {'add_token': addToken ?? true}),
    );
  }

  @override
  Future<Response> put(
    String? url, {
    dynamic body,
    Map<String, String>? headers,
    Encoding? encoding,
    bool? addToken,
  }) async {
    return await dio.put(
      url!,
      data: body,
      options: Options(
          headers: headers ?? this.headers,
          extra: {'add_token': addToken ?? true}),
    );
  }

  @override
  Future<Response> delete(
    String? url, {
    dynamic body,
    Map<String, String>? headers,
    Encoding? encoding,
    bool? addToken,
  }) async {
    return await dio.delete(
      url!,
      options: Options(
          headers: headers ?? this.headers,
          extra: {'add_token': addToken ?? true}),
    );
  }
}
