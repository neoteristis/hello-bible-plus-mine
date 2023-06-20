import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/registration_repository.dart';

class SignInWithGoogleUsecase implements Usecase<User, NoParams> {
  final RegistrationRepository repo;
  SignInWithGoogleUsecase(
    this.repo,
  );
  @override
  Future<Either<Failure, User?>> call(NoParams _) async {
    return await repo.signInWithGoogle();
  }
}
