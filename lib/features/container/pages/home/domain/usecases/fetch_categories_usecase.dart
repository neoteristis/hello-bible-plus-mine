import 'package:dartz/dartz.dart';
import 'package:gpt/core/error/failure.dart';
import 'package:gpt/core/usecase/usecase.dart';
import 'package:gpt/features/chat/domain/entities/category.dart';

import '../repositories/home_repository.dart';


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
