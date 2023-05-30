import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/entities.dart';
import '../repositories/subscription_repository.dart';

class PaymentIntentUsecase implements Usecase<PaymentData, PPayment> {
  final SubscriptionRepository subscriptionRepository;
  PaymentIntentUsecase(
    this.subscriptionRepository,
  );
  @override
  Future<Either<Failure, PaymentData>> call(PPayment payment) async {
    return await subscriptionRepository.sendPayment(payment);
  }
}

class PPayment extends Equatable {
  final double? amount;
  const PPayment({
    this.amount,
  });

  @override
  List<Object?> get props => [amount];

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
    };
  }
}
