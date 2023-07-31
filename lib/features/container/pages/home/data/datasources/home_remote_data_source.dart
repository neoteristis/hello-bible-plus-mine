import 'package:gpt/features/chat/domain/entities/category.dart';
import 'package:gpt/features/chat/domain/entities/category_by_section.dart';

abstract class HomeRemoteDataSource {

  Future<List<Category>> fetchCategories();

  Future<List<CategoriesBySection>> fetchCategoriesBySection();
}
