import 'package:dartz/dartz.dart';
import 'package:gpt/features/chat/domain/entities/category.dart';
import 'package:gpt/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class FetchCategoriesUsecase implements Usecase<List<Category>, NoParams> {
  final HomeRepository repository;

  FetchCategoriesUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Category>>> call(NoParams _) async {
    return await repository.fetchCategories();
  }
}
