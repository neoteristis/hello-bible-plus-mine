import 'dart:convert';

import 'package:dio/dio.dart';

abstract class BaseRepository {
  Future<Response> post(
    String? url, {
    dynamic body,
    Map<String, String>? headers,
    Encoding? encoding,
    bool? addToken,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> get(
    String? url, {
    Map<String, String>? headers,
    bool? addToken,
    Options? options,
    // ResponseType? responseType,
  });

  Future<Response> patch(
    String? url, {
    dynamic body,
    Map<String, String>? headers,
    Encoding? encoding,
    bool? addToken,
  });

  Future<Response> put(
    String? url, {
    dynamic body,
    Map<String, String>? headers,
    Encoding? encoding,
    bool? addToken,
  });

  Future<Response> delete(
    String? url, {
    dynamic body,
    Map<String, String>? headers,
    Encoding? encoding,
    bool? addToken,
  });
}
