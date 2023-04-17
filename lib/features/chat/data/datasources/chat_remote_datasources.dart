import 'package:dio/dio.dart';

import '../../../../core/base_repository/base_repository.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/category.dart';

abstract class ChatRemoteDatasources {
  Future<List<Category>> fetchCategories();
}

class ChatRemoteDatasourcesImp implements ChatRemoteDatasources {
  final BaseRepository baseRepo;
  const ChatRemoteDatasourcesImp(
    this.baseRepo,
  );
  @override
  Future<List<Category>> fetchCategories() async {
    try {
      final res = await baseRepo.get(ApiConstants.categories);
      return (res.data as List).map((m) => Category.fromJson(m)).toList();
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
