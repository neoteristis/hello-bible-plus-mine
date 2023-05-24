import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/entities/pagination.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/entities.dart';
import '../repositories/chat_repository.dart';

class FetchHistoricalUsecase
    implements Usecase<List<HistoricalConversation>, PHistorical> {
  final ChatRepository chatRepository;
  FetchHistoricalUsecase(
    this.chatRepository,
  );
  @override
  Future<Either<Failure, List<HistoricalConversation>>> call(
      PHistorical param) async {
    return await chatRepository.fetchHistorical(param);
  }
}

class PHistorical extends Equatable {
  final Pagination? pagination;
  final String? uid;

  const PHistorical({
    this.pagination,
    this.uid,
  });

  @override
  List<Object?> get props => [
        pagination,
        uid,
      ];

  PHistorical copyWith({
    Pagination? pagination,
    String? uid,
  }) {
    return PHistorical(
      pagination: pagination ?? this.pagination,
      uid: uid ?? this.uid,
    );
  }
}
