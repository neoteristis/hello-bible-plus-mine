import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../../core/base_repository/base_repository.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/models/message_response.dart';
import '../../domain/entities/entities.dart';

abstract class RegistrationRemoteDatasources {
  Future<UserResponse> registration(User user);
  Future<UserResponse> login(User user);
  Future<bool> checkEmail(String email);
  Future<User> updateUser(User user);
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
      if (photo != null) {
        print(photo);
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
}
