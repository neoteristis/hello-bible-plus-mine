import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/conversation.dart';
import '../repositories/chat_repository.dart';

class CancelMessageComingUsecase implements Usecase<dynamic, Conversation> {
  final ChatRepository chatRepository;
  CancelMessageComingUsecase(
    this.chatRepository,
  );
  @override
  Future<Either<Failure, dynamic>> call(Conversation param) async {
    return await chatRepository.cancelMessageComing(param);
  }
}
