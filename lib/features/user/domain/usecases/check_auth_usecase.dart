import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/registration_repository.dart';

class CheckAuthUsecase extends Usecase<dynamic, NoParams> {
  final RegistrationRepository repo;
  CheckAuthUsecase(
    this.repo,
  );
  @override
  Future<Either<Failure, dynamic>> call(NoParams params) async {
    await Future.delayed(const Duration(seconds: 3));
    return await repo.checkAuth();
  }
}
