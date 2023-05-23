import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/entities.dart';
import '../repositories/chat_repository.dart';

class SendMessagesUsecase implements Usecase<Message, MessageParam> {
  final ChatRepository chatRepository;
  SendMessagesUsecase(
    this.chatRepository,
  );
  @override
  Future<Either<Failure, Message>> call(MessageParam param) async {
    return await chatRepository.sendMessage(param);
  }
}

class MessageParam extends Equatable {
  final String? content;
  final Conversation? conversation;
  final bool? streamMessage;
  const MessageParam({
    this.content,
    this.conversation,
    this.streamMessage,
  });

  Map<String, dynamic> toJson() => {
        'content': content,
        'role': 'user'
        // 'conversation': conversation?.id,
      };

  @override
  List<Object?> get props => [
        content,
        conversation,
        streamMessage,
      ];
}
