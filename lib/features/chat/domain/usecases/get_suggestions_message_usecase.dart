import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/chat_repository.dart';
import 'send_messages_usecase.dart';

class GetSuggestionsMessageUsecase
    implements Usecase<List<String>, MessageParam> {
  final ChatRepository chatRepository;
  GetSuggestionsMessageUsecase(
    this.chatRepository,
  );
  @override
  Future<Either<Failure, List<String>>> call(MessageParam param) async {
    return await chatRepository.getSuggestions(param);
  }
}

// class MessageParam extends Equatable {
//   final String? content;
//   final Conversation? conversation;
//   final bool? streamMessage;
//   const MessageParam({
//     this.content,
//     this.conversation,
//     this.streamMessage,
//   });

//   Map<String, dynamic> toJson() => {
//         'content': content,
//         'role': 'user'
//         // 'conversation': conversation?.id,
//       };

//   @override
//   List<Object?> get props => [
//         content,
//         conversation,
//         streamMessage,
//       ];
// }
