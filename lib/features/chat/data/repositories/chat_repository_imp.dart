import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';
import 'package:gpt/features/chat/domain/entities/category.dart';

import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasources.dart';

class ChatRepositoryImp implements ChatRepository {
  final ChatRemoteDatasourcesImp remote;
  ChatRepositoryImp({
    required this.remote,
  });
  @override
  Future<Either<Failure, List<Category>>> fetchCategories() async {
    throw UnimplementedError();
  }
}
