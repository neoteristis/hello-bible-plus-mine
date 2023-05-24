import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/entities.dart';
import '../usecases/change_conversation_usecase.dart';
import '../usecases/fetch_historical_usecase.dart';
import '../usecases/send_messages_usecase.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<Category>>> fetchCategories();
  Future<Either<Failure, List<CategoriesBySection>>> fetchCategoriesBySection();
  Future<Either<Failure, Conversation>> changeConversation(
      PChangeConversation cat);
  Future<Either<Failure, Message>> sendMessage(MessageParam param);
  Future<Either<Failure, dynamic>> getResponseMessages(String idConversation);
  Future<Either<Failure, List<HistoricalConversation>>> fetchHistorical(
      PHistorical param);
  // Future<Either<Failure, Conversation>> getConversationById(
  //     String conversationId);
}
