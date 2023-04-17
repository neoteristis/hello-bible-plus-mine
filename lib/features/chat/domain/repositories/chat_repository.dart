import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/category.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<Category>>> fetchCategories();
}
