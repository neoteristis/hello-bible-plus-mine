import 'package:gpt/features/chat/domain/usecases/send_messages_usecase.dart';

import '../../../../core/base_repository/base_repository.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/entities.dart';

abstract class ChatRemoteDatasources {
  Future<List<Category>> fetchCategories();
  Future<Conversation> changeConversation(Category cat);
  Future<Message> sendMessage(MessageParam param);
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
  Future<Conversation> changeConversation(Category cat) async {
    try {
      final res = await baseRepo.post(ApiConstants.conversation, body: {
        "category": cat.id,
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
      final res =
          await baseRepo.post(ApiConstants.messages, body: param.toJson());
      return Message.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
