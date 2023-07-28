import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:gpt/core/helper/notifications.dart';
import 'package:logger/logger.dart';

import '../../../../core/base_repository/base_repository.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/entities/token.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/models/message_response.dart';
import '../../domain/entities/entities.dart';

abstract class RegistrationRemoteDatasources {
  Future<UserResponse> registration(User user);

  Future<UserResponse> login(User user);

  Future<bool> checkEmail(String email);

  Future<User> updateUser(User user);

  Future<Token> refreshToken(String refresh);

  Future<UserResponse> socialConnect(User user);

  Future<UserResponse> appleConnect(Map<String, String> queryParams);

  Future sendFirebaseToken(User user);

  Future<User> getUser();
}

class RegistrationRemoteDatasourcesImp
    implements RegistrationRemoteDatasources {
  final BaseRepository baseRepo;

  const RegistrationRemoteDatasourcesImp(this.baseRepo);

  @override
  Future<UserResponse> registration(User user) async {
    try {
      final res = await baseRepo.post(ApiConstants.registration(),
          body: user.toJson_1());
      return UserResponse.fromJson(res.data);
    } on DioError catch (e) {
      Logger().w(e);
      final res = e.response;
      final message = res?.data != null
          ? MessageResponse.fromJson(res?.data).message
          : e.toString();
      throw ServerException(message: message);
    }
  }

  @override
  Future<bool> checkEmail(String email) async {
    try {
      await baseRepo.get(
        ApiConstants.checkEmail(email),
        addToken: false,
      );
      return true;
    } on DioError catch (e) {
      Logger().w(e);
      final res = e.response;
      if (res?.statusCode == 404) {
        return false;
      }
      final message = res?.data != null
          ? MessageResponse.fromJson(res?.data).message
          : e.toString();
      throw ServerException(message: message);
    }
  }

  @override
  Future<User> updateUser(User user) async {
    try {
      final body = user.toJson_2();
      final photo = user.photo;
      print(photo);
      if (photo != null) {
        body['profile'] = await MultipartFile.fromFile(
          photo,
        );
      }
      final FormData formData = FormData.fromMap(body);
      final res = await baseRepo.patch(
        ApiConstants.registration(),
        body: formData,
        // headers: {
        //   'Content-Type': 'multipart/form-data',
        // },
      );
      return User.fromJson(res.data);
    } on DioError catch (e) {
      Logger().w(e);
      final res = e.response;

      final message = res?.data != null
          ? MessageResponse.fromJson(res?.data).message
          : e.toString();
      throw ServerException(message: message);
    }
  }

  @override
  Future<UserResponse> login(User user) async {
    try {
      final res = await baseRepo.post(ApiConstants.login,
          body: user.toJsonLogin(), addToken: false);
      return UserResponse.fromJson(res.data);
    } on DioError catch (e) {
      Logger().w(e);
      final res = e.response;
      String? message;
      if (res?.statusCode == 401) {
        message = 'Identifiants invalides';
      } else {
        message = res?.data != null
            ? MessageResponse.fromJson(res?.data).message
            : e.toString();
      }
      throw ServerException(message: message);
    }
  }

  @override
  Future<Token> refreshToken(String refresh) async {
    try {
      final res = await baseRepo.post(
        '/api/auth/token/refresh',
        body: {
          'refresh_token': refreshToken,
        },
        addToken: false,
      );
      return Token.fromJson(res.data);
    } on DioError catch (e) {
      Logger().w(e);
      final res = e.response;
      String? message;

      message = res?.data != null
          ? MessageResponse.fromJson(res?.data).message
          : e.toString();

      throw ServerException(message: message);
    }
  }

  @override
  Future<UserResponse> socialConnect(User user) async {
    try {
      final body = user.toJson();
      print(body);
      // final photo = user.photo;
      // if (photo != null) {
      //   body['profile'] = await MultipartFile.fromFile(
      //     photo,
      //   );
      // }
      final FormData formData = FormData.fromMap(body);

      final res =
          await baseRepo.post(ApiConstants.registration(), body: formData);
      return UserResponse.fromJson(res.data);
    } on DioError catch (e) {
      // Logger().w(e);

      final res = e.response;
      final message = res?.data != null
          ? MessageResponse.fromJson(res?.data).message
          : e.toString();
      // Logger().w(message);
      throw ServerException(message: message);
    }
  }

  @override
  Future sendFirebaseToken(User user) async {
    final token = await FirebaseMessaging.instance.getToken();
    await setToken(token);
    final uid = user.idString;
    if (uid != null) {
      try {
        FirebaseMessaging.instance.subscribeToTopic('hello_bible_topic');
        FirebaseMessaging.instance.subscribeToTopic(uid);
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }

  @override
  Future<User> getUser() async {
    try {
      final res = await baseRepo.get(ApiConstants.me);
      return User.fromJson(res.data);
    } on DioError catch (e) {
      // Logger().w(e);

      final res = e.response;
      final message = res?.data != null
          ? MessageResponse.fromJson(res?.data).message
          : e.toString();
      // Logger().w(message);
      throw ServerException(message: message);
    }
  }

  @override
  Future<UserResponse> appleConnect(Map<String, String> queryParams) async {
    try {
      // final res = await Dio().postUri(uri);
      // print(res);
      final res = await baseRepo.post(
        '/api/sign_in_with_apple',
        queryParameters: queryParams,
        addToken: false,
      );
      return UserResponse.fromJson(res.data);
    } on DioError catch (e) {
      Logger().w(e.error);
      final res = e.response;
      String? message;

      message = res?.data != null
          ? MessageResponse.fromJson(res?.data).message
          : e.toString();
      throw ServerException(message: message);
    }
  }
}
