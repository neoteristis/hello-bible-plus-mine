import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/entities.dart';
import '../repositories/chat_repository.dart';

class DeleteHistoricUsecase
    implements Usecase<dynamic, HistoricalConversation> {
  final ChatRepository repo;
  DeleteHistoricUsecase(this.repo);
  @override
  Future<Either<Failure, dynamic>> call(HistoricalConversation param) async {
    return await repo.deleteHistoric(param);
  }
}
