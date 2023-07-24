import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/chat_repository.dart';

class GetResponseMessagesUsecase
    implements Usecase<dynamic, PGetResponseMessage> {
  final ChatRepository chatRepository;
  GetResponseMessagesUsecase(
    this.chatRepository,
  );
  @override
  Future<Either<Failure, dynamic>> call(PGetResponseMessage param) async {
    return await chatRepository.getResponseMessages(param);
  }
}

class PGetResponseMessage extends Equatable {
  final String idConversation;
  final int? messageId;
  const PGetResponseMessage({
    required this.idConversation,
    this.messageId,
  });
  @override
  List<Object?> get props => [
        idConversation,
        messageId,
      ];
}
