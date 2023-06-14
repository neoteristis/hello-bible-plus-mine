import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

abstract class RegistrationRepository {
  Future<Either<Failure, User>> register(User user);
  Future<Either<Failure, User>> login(User user);
  Future<Either<Failure, dynamic>> checkAuth();
  Future<Either<Failure, dynamic>> deleteAuth();
  Future<Either<Failure, bool>> checkEmail(String email);
  Future<Either<Failure, User>> updateUser(User user);
  Future<Either<Failure, XFile?>> getPicture(ImageSource source);
}
