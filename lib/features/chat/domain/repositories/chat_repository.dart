import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/entities.dart';
import '../usecases/usecases.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<Category>>> fetchCategories();
  Future<Either<Failure, List<CategoriesBySection>>> fetchCategoriesBySection();
  Future<Either<Failure, Conversation>> changeConversation(
      PChangeConversation cat);
  Future<Either<Failure, Message>> sendMessage(MessageParam param);
  Future<Either<Failure, dynamic>> getResponseMessages(
      PGetResponseMessage idConversation);
  Future<Either<Failure, List<HistoricalConversation>>> fetchHistorical(
      PHistorical param);
  Future<Either<Failure, Conversation>> getConversationById(
      String conversationId);
  Future<Either<Failure, List<String>>> getSuggestions(MessageParam param);
  Future<Either<Failure, dynamic>> cancelMessageComing(
      Conversation conversation);
  Future<Either<Failure, dynamic>> deleteHistoric(
      HistoricalConversation historic);
  Future<Either<Failure, dynamic>> editHistoric(PEditHistoric param);
}
