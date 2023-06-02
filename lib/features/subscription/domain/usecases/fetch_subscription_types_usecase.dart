import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';
import 'package:gpt/features/subscription/domain/repositories/subscription_repository.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/entities.dart';

class FetchSubscriptionTypesUsecase
    implements Usecase<List<SubscriptionType>, NoParams> {
  final SubscriptionRepository repo;

  FetchSubscriptionTypesUsecase(this.repo);
  @override
  Future<Either<Failure, List<SubscriptionType>>> call(NoParams _) async {
    return await repo.getSubscriptionsType();
  }
}
