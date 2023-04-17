import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/category.dart';
import '../entities/conversation.dart';
import '../repositories/chat_repository.dart';

class ChangeConversationUsecase implements Usecase<Conversation, Category> {
  final ChatRepository chatRepository;
  ChangeConversationUsecase(
    this.chatRepository,
  );
  @override
  Future<Either<Failure, Conversation>> call(Category category) async {
    return await chatRepository.changeConversation(category);
  }
}
