import 'package:dio/dio.dart';
import 'package:gpt/features/chat/domain/usecases/send_messages_usecase.dart';

import '../../../../core/base_repository/base_repository.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/fetch_historical_usecase.dart';

abstract class ChatRemoteDatasources {
  Future<List<Category>> fetchCategories();
  Future<Conversation> changeConversation({
    required Category cat,
    required String uid,
    String? conversationId,
  });
  Future<Message> sendMessage(MessageParam param);
  Future getResponseMessages(String idConversation);
  Future<List<CategoriesBySection>> fetchCategoriesBySection();
  Future<List<HistoricalConversation>> fetchHistoricalConversation(
      PHistorical param);
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

  @override
  Future<Conversation> changeConversation({
    required Category cat,
    required String uid,
    String? conversationId,
  }) async {
    try {
      Response res;
      if (conversationId != null) {
        res = await baseRepo.patch(
            ApiConstants.conversation(conversationId: conversationId),
            body: {
              'category': cat.id,
              'user': uid,
            });
      }
      res = await baseRepo.post(ApiConstants.conversation(), body: {
        'category': cat.id,
        'user': uid,
      });
      return Conversation.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Message> sendMessage(MessageParam param) async {
    try {
      final res = await baseRepo.post(
          ApiConstants.messages(param.conversation!.id!),
          body: param.toJson());
      final message = Message.fromJson(res.data);
      return message;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future getResponseMessages(String idConversation) async {
    try {
      final res = await baseRepo.get(
        ApiConstants.answer(idConversation),
        options: Options(headers: {
          'Accept': 'text/event-stream',
          'Cache-Control': 'no-cache',
        }, responseType: ResponseType.stream),
      );
      return res;
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<CategoriesBySection>> fetchCategoriesBySection() async {
    try {
      final res = await baseRepo.get(ApiConstants.categoriesBySection);

      return (res.data as List)
          .map((m) => CategoriesBySection.fromJson(m))
          .toList();
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<HistoricalConversation>> fetchHistoricalConversation(
      PHistorical param) async {
    try {
      final res = await baseRepo.get(ApiConstants.historical(param));

      return (res.data as List)
          .map((m) => HistoricalConversation.fromJson(m))
          .toList();
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
