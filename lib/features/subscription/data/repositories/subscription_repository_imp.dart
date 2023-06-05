import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';
import 'package:gpt/core/models/message_response.dart';
import 'package:gpt/features/subscription/domain/usecases/payment_intent_usecase.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../../user/data/datasources/datasources.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../datasources/subscription_remote_datasources.dart';

class SubscriptionRepositoryImp implements SubscriptionRepository {
  final SubscriptionRemoteDatasources remote;
  final RegistrationLocalDatasources registrationLocal;
  final NetworkInfo networkInfo;
  SubscriptionRepositoryImp({
    required this.remote,
    required this.registrationLocal,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, PaymentData>> sendPayment(PPayment params) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.sendPayment(params);
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> initPaymentSheet(PaymentData data) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.initPaymentSheet(data);
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> presentPaymentSheet() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.presentPaymentSheet();
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> confirmPaymentSheet() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.confirmPaymentSheet();
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, List<SubscriptionType>>> getSubscriptionsType() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.getSubscriptionsType();
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateSubsctiption(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await registrationLocal.getUser();
        final uid = user?.idString;
        if (uid != null) {
          final res =
              await remote.updateSubscription(subscriptionId: id, uid: uid);
          return Right(res);
        }
        return const Left(CacheFailure());
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, MessageResponse>> checkCode(String code) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.checkCode(code);
        return Right(res);
      } on NotFoundException {
        return const Left(NotFoundFailure());
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }
}
