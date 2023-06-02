import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../../core/base_repository/base_repository.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/models/message_response.dart';
import '../../domain/entities/entities.dart';

abstract class RegistrationRemoteDatasources {
  Future<UserResponse> registration(User user);
}

class RegistrationRemoteDatasourcesImp
    implements RegistrationRemoteDatasources {
  final BaseRepository baseRepo;

  const RegistrationRemoteDatasourcesImp(this.baseRepo);
  @override
  Future<UserResponse> registration(User user) async {
    try {
      final res =
          await baseRepo.post(ApiConstants.registration(), body: user.toJson());
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
}
