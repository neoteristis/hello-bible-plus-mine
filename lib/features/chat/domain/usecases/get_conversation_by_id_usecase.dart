// import 'package:dartz/dartz.dart';

// import '../../../../core/error/failure.dart';
// import '../../../../core/usecase/usecase.dart';
// import '../entities/conversation.dart';
// import '../repositories/chat_repository.dart';

// class GetConversationByIdUsecase
//     implements Usecase<Conversation, String> {
//   final ChatRepository chatRepository;
//   GetConversationByIdUsecase(
//     this.chatRepository,
//   );
//   @override
//   Future<Either<Failure, Conversation>> call(String conversationId) async {
//     return await chatRepository.getConversationById(conversationId);
//   }
// }