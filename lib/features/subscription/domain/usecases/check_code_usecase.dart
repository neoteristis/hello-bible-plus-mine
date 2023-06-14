import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';

import '../../../../core/models/message_response.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/subscription_repository.dart';

class CheckCodeUsecase implements Usecase<MessageResponse, String> {
  final SubscriptionRepository subscription;
  CheckCodeUsecase(
    this.subscription,
  );
  @override
  Future<Either<Failure, MessageResponse?>> call(String code) async {
    return await subscription.checkCode(code);
  }
}
