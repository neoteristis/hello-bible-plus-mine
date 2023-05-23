import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/registration_repository.dart';

class RegistrationUsecase extends Usecase<User, User> {
  final RegistrationRepository repo;
  RegistrationUsecase(
    this.repo,
  );
  @override
  Future<Either<Failure, User>> call(User params) async {
    return await repo.register(params);
  }
}
