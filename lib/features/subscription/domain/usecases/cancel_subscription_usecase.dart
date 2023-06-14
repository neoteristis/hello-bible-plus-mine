import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/subscription_repository.dart';

class CancelSubscriptionUsecase implements Usecase<dynamic, NoParams> {
  final SubscriptionRepository repo;
  CancelSubscriptionUsecase(
    this.repo,
  );
  @override
  Future<Either<Failure, dynamic>> call(NoParams params) async {
    // TODO: implement call
    throw UnimplementedError();
  }
}
