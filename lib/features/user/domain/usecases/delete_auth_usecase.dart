import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/registration_repository.dart';

class DeleteAuthUsecase extends Usecase<dynamic, NoParams> {
  final RegistrationRepository repo;
  DeleteAuthUsecase(
    this.repo,
  );
  @override
  Future<Either<Failure, dynamic>> call(NoParams _) async {
    return await repo.deleteAuth();
  }
}
