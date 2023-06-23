import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/registration_repository.dart';

class GetProfileUsecase extends Usecase<dynamic, NoParams> {
  final RegistrationRepository repo;
  GetProfileUsecase(
    this.repo,
  );
  @override
  Future<Either<Failure, dynamic>> call(NoParams _) async {
    return await repo.getUser();
  }
}
