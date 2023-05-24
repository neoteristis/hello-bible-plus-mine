import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/category.dart';
import '../entities/conversation.dart';
import '../repositories/chat_repository.dart';

class ChangeConversationUsecase
    implements Usecase<Conversation, PChangeConversation> {
  final ChatRepository chatRepository;
  ChangeConversationUsecase(
    this.chatRepository,
  );
  @override
  Future<Either<Failure, Conversation>> call(PChangeConversation param) async {
    return await chatRepository.changeConversation(param);
  }
}

class PChangeConversation extends Equatable {
  final Category category;
  final String? conversationId;
  const PChangeConversation({
    required this.category,
    this.conversationId,
  });
  @override
  List<Object?> get props => [
        category,
        conversationId,
      ];
}
