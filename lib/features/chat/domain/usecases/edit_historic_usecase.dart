import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:gpt/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/entities.dart';
import '../repositories/chat_repository.dart';

class EditHistoricUsecase implements Usecase<dynamic, PEditHistoric> {
  final ChatRepository repo;
  EditHistoricUsecase(this.repo);
  @override
  Future<Either<Failure, dynamic>> call(PEditHistoric param) async {
    return await repo.editHistoric(param);
  }
}

class PEditHistoric extends Equatable {
  final String? title;
  final HistoricalConversation? historicalConversation;
  const PEditHistoric({
    this.title,
    this.historicalConversation,
  });
  @override
  List<Object?> get props => [
        title,
        historicalConversation,
      ];
}
