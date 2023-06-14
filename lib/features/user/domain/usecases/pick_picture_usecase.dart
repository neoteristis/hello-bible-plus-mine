import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/registration_repository.dart';

class PickPictureUsecase implements Usecase<dynamic, ImageSource> {
  final RegistrationRepository repository;
  PickPictureUsecase(
    this.repository,
  );
  @override
  Future<Either<Failure, XFile?>> call(ImageSource source) async {
    return await repository.getPicture(source);
  }
}
