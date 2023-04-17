import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/category.dart';
import '../entities/conversation.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<Category>>> fetchCategories();
  Future<Either<Failure, Conversation>> changeConversation(Category cat);
}
