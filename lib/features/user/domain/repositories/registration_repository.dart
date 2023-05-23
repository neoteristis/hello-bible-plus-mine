import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

abstract class RegistrationRepository {
  Future<Either<Failure, User>> register(User user);
  Future<Either<Failure, dynamic>> checkAuth();
}
