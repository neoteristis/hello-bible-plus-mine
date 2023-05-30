import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/entities.dart';
import '../usecases/payment_intent_usecase.dart';

abstract class SubscriptionRepository {
  Future<Either<Failure, PaymentData>> sendPayment(PPayment params);
}
