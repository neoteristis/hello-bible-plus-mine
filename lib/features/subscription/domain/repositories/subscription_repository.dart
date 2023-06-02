import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/entities.dart';
import '../usecases/payment_intent_usecase.dart';

abstract class SubscriptionRepository {
  Future<Either<Failure, PaymentData>> sendPayment(PPayment params);
  Future<Either<Failure, bool>> initPaymentSheet(PaymentData data);
  Future<Either<Failure, bool>> presentPaymentSheet();
  Future<Either<Failure, bool>> confirmPaymentSheet();
  Future<Either<Failure, List<SubscriptionType>>> getSubscriptionsType();
  Future<Either<Failure, dynamic>> updateSubsctiption(String id);
}
