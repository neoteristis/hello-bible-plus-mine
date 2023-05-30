import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';
import 'package:gpt/features/subscription/domain/usecases/payment_intent_usecase.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../datasources/subscription_remote_datasources.dart';

class SubscriptionRepositoryImp implements SubscriptionRepository {
  final SubscriptionRemoteDatasources remote;
  final NetworkInfo networkInfo;
  SubscriptionRepositoryImp({
    required this.remote,
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
}
