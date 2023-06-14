import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';
import 'package:gpt/features/user/domain/entities/user.dart';
import 'package:gpt/features/user/domain/repositories/registration_repository.dart';
import 'package:image_picker/image_picker.dart';

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
          local.saveUser(userRes);
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

  @override
  Future<Either<Failure, dynamic>> deleteAuth() async {
    try {
      return Right(await local.deleteAuth());
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmail(String email) async {
    if (await network.isConnected) {
      try {
        final res = await remote.checkEmail(email);

        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    }
    return const Left(NoConnexionFailure());
  }

  @override
  Future<Either<Failure, User>> updateUser(User user) async {
    if (await network.isConnected) {
      try {
        final res = await remote.updateUser(user);

        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    }
    return const Left(NoConnexionFailure());
  }

  @override
  Future<Either<Failure, XFile?>> getPicture(ImageSource source) async {
    final file = await local.getPicture(source);
    if (file == null) {
      return const Left(ServerFailure(info: 'Format non prise en charge'));
    }
    return Right(file);
  }

  @override
  Future<Either<Failure, User>> login(User user) async {
    if (await network.isConnected) {
      try {
        final res = await remote.login(user);
        final token = res.token;
        final userRes = res.user;
        if (token != null && userRes != null) {
          local.saveToken(token);
          local.saveUser(userRes);
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
}
