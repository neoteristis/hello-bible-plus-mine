import 'package:dartz/dartz.dart';
import 'package:gpt/core/error/failure.dart';
import 'package:gpt/core/usecase/usecase.dart';
import 'package:gpt/features/chat/domain/entities/category_by_section.dart';
import 'package:gpt/features/container/pages/home/domain/repositories/home_repository.dart';


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
