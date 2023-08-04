import 'package:gpt/core/base_repository/base_repository.dart';
import 'package:gpt/core/constants/api_constants.dart';
import 'package:gpt/core/error/exception.dart';
import 'package:gpt/features/chat/domain/entities/category.dart';
import 'package:gpt/features/chat/domain/entities/category_by_section.dart';

import 'home_remote_data_source.dart';

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final BaseRepository baseRepo;

  HomeRemoteDataSourceImpl(
    this.baseRepo,
  );

  @override
  Future<List<Category>> fetchCategories() async {
    try {
      final res = await baseRepo.get(ApiConstants.categories);

      final lists =
          (res.data as List).map((m) => Category.fromJson(m)).toList();

      return lists;
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<CategoriesBySection>> fetchCategoriesBySection() async {
    try {
      final res =
          await baseRepo.get(ApiConstants.categoriesBySection, addToken: true);

      return (res.data as List)
          .map((m) => CategoriesBySection.fromJson(m))
          .toList();
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
