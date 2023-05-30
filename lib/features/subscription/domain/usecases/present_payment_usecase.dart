import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/subscription_repository.dart';

class PresentPaymentUsecase implements Usecase<bool, NoParams> {
  final SubscriptionRepository subscriptionRepository;
  PresentPaymentUsecase(
    this.subscriptionRepository,
  );
  @override
  Future<Either<Failure, bool>> call(NoParams _) async {
    return await subscriptionRepository.presentPaymentSheet();
  }
}
