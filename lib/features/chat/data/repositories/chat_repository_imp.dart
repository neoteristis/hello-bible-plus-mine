import 'package:dartz/dartz.dart';
import 'package:gpt/core/error/exception.dart';

import 'package:gpt/core/error/failure.dart';
import 'package:gpt/features/chat/domain/entities/category.dart';
import 'package:gpt/features/chat/domain/entities/conversation.dart';
import 'package:gpt/features/chat/domain/usecases/send_messages_usecase.dart';
import 'package:gpt/features/chat/domain/entities/message.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasources.dart';

class ChatRepositoryImp implements ChatRepository {
  final ChatRemoteDatasourcesImp remote;
  final NetworkInfo networkInfo;
  ChatRepositoryImp({
    required this.remote,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Category>>> fetchCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.fetchCategories();
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, Conversation>> changeConversation(Category cat) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.changeConversation(cat);
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage(MessageParam param) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.sendMessage(param);
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> getResponseMessages(
      int idConversation) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.getResponseMessages(idConversation);
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }
}
