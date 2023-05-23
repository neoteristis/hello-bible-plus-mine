import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';
import 'package:gpt/features/user/domain/entities/user.dart';
import 'package:gpt/features/user/domain/repositories/registration_repository.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/datasources.dart';

class RegistrationRepositoryImp implements RegistrationRepository {
  final RegistrationRemoteDatasources remote;
  final RegistrationLocalDatasources local;
  final NetworkInfo network;

  RegistrationRepositoryImp({
    required this.remote,
    required this.local,
    required this.network,
  });

  @override
  Future<Either<Failure, User>> register(User user) async {
    if (await network.isConnected) {
      try {
        final res = await remote.registration(user);
        final token = res.token;
        final userRes = res.user;
        if (token != null && userRes != null) {
          local.saveToken(token);
          local.saveUser(user);
        } else {
          return const Left(ServerFailure(info: 'Une erreur s\'est produite'));
        }

        return Right(userRes);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    }
    return const Left(NoConnexionFailure());
  }

  @override
  Future<Either<Failure, dynamic>> checkAuth() async {
    try {
      return Right(await local.getToken());
    } catch (e) {
      return const Left(CacheFailure());
    }
  }
}
