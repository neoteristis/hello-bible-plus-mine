import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/registration_repository.dart';

class CheckEmailUsecase extends Usecase<bool, String> {
  final RegistrationRepository repo;
  CheckEmailUsecase(
    this.repo,
  );
  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repo.checkEmail(params);
  }
}
