import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/registration_repository.dart';

class SignInWithAppleUsecase implements Usecase<User, NoParams> {
  final RegistrationRepository repo;
  SignInWithAppleUsecase(
    this.repo,
  );
  @override
  Future<Either<Failure, User?>> call(NoParams _) async {
    return await repo.signInWithApple();
  }
}
