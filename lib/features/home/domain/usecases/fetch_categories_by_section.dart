import 'package:dartz/dartz.dart';
import 'package:gpt/features/chat/domain/entities/category_by_section.dart';
import 'package:gpt/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class FetchCategoriesBySectionUsecase implements Usecase<List<CategoriesBySection>, NoParams> {
  final HomeRepository repository;

  FetchCategoriesBySectionUsecase(
    this.repository,
  );

  @override
  Future<Either<Failure, List<CategoriesBySection>>> call(NoParams _) async {
    return await repository.fetchCategoriesBySection();
  }
}
