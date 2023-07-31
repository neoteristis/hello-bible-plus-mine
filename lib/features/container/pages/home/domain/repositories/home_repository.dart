import 'package:dartz/dartz.dart';
import 'package:gpt/core/error/failure.dart';
import 'package:gpt/features/chat/domain/entities/category.dart';
import 'package:gpt/features/chat/domain/entities/category_by_section.dart';

abstract class HomeRepository {

  Future<Either<Failure, List<Category>>> fetchCategories();
  Future<Either<Failure, List<CategoriesBySection>>> fetchCategoriesBySection();
}
