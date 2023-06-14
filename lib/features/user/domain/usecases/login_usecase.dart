import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/registration_repository.dart';

class LoginUsecase extends Usecase<User, User> {
  final RegistrationRepository repo;
  LoginUsecase(
    this.repo,
  );
  @override
  Future<Either<Failure, User>> call(User params) async {
    return await repo.login(params);
  }
}
