import 'package:dio/dio.dart';
import 'package:gpt/features/chat/domain/usecases/send_messages_usecase.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../core/base_repository/base_repository.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/entities/token.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/helper/log.dart';
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
  Future getResponseMessages(String idConversation, int? idMessage);
  Future<List<CategoriesBySection>> fetchCategoriesBySection();
  Future<List<HistoricalConversation>> fetchHistoricalConversation(
      PHistorical param);
  Future<Conversation> getConversationById(String conversationId);
  Future<List<String>> getSuggestions(MessageParam param);
  Future cancelMessage(Conversation param);
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

      final lists =
          (res.data as List).map((m) => Category.fromJson(m)).toList();

      return lists;
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
    } on DioError catch (e) {
      final res = e.response;
      if (res?.statusCode == 400) {
        throw WarningWordException();
      }
      throw ServerException();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future getResponseMessages(String idConversation, int? idMessage) async {
    try {
      final res = await baseRepo.get(
        ApiConstants.answer(idConversation, idMessage),
        options: Options(
          headers: {
            'Accept': 'text/event-stream',
            'Cache-Control': 'no-cache',
            // 'Authorization': 'Bearer ${token.token}',
          },
          responseType: ResponseType.stream,
          extra: {'add_token': true},
        ),
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
      final res =
          await baseRepo.get(ApiConstants.categoriesBySection, addToken: true);
      final lists = (res.data as List)
          .map((m) => CategoriesBySection.fromJson(m))
          .toList();
      return lists;
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<HistoricalConversation>> fetchHistoricalConversation(
    PHistorical param,
  ) async {
    try {
      final res = await baseRepo.get(
        ApiConstants.historical(param),
        addToken: true,
      );
      return (res.data as List)
          .map((m) => HistoricalConversation.fromJson(m))
          .toList();
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Conversation> getConversationById(String conversationId) async {
    try {
      final res = await baseRepo
          .get(ApiConstants.conversation(conversationId: conversationId));

      return Conversation.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<String>> getSuggestions(MessageParam param) async {
    try {
      final res = await baseRepo.post(
        ApiConstants.suggestions(param.conversation!.id!),
        body: param.toJson(),
      );
      final data = res.data['data'] as List;
      if (data.isEmpty) {
        return [];
      }
      return data.map((m) => m.toString()).toList();
      // return [];
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future cancelMessage(Conversation param) async {
    try {
      if (param.id != null) {
        final res = await baseRepo.post(
          ApiConstants.stop(param.id!),
        );
        return res.data;
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
