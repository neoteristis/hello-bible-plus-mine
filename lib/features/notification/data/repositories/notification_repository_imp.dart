import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';
import 'package:gpt/features/notification/domain/entities/notif_by_category.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';

class NotificationRepositoryImp implements NotificationRepository {
  final NetworkInfo networkInfo;
  final NotificationRemoteDatasource remote;
  NotificationRepositoryImp({
    required this.networkInfo,
    required this.remote,
  });
  @override
  Future<Either<Failure, List<NotificationTime>>>
      getValueNotifByCategory() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.getValueNotifByCategory();
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> switchNotifValue(
      NotificationTime notif) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.switchNotifValue(notif);
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> changeNotifTime(
      List<NotificationTime> notifs) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.changeNotifTime(notifs);
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }
}
