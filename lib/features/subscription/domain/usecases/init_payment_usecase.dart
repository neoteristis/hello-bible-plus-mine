import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/entities.dart';
import '../repositories/subscription_repository.dart';

class InitPaymentUsecase implements Usecase<bool, PaymentData> {
  final SubscriptionRepository subscriptionRepository;
  InitPaymentUsecase(
    this.subscriptionRepository,
  );
  @override
  Future<Either<Failure, bool>> call(PaymentData payment) async {
    return await subscriptionRepository.initPaymentSheet(payment);
  }
}
