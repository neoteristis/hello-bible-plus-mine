import 'package:dartz/dartz.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gpt/core/error/exception.dart';

import 'package:gpt/core/error/failure.dart';
import 'package:gpt/features/chat/domain/entities/category.dart';
import 'package:gpt/features/chat/domain/entities/category_by_section.dart';
import 'package:gpt/features/chat/domain/entities/conversation.dart';
import 'package:gpt/features/chat/domain/entities/historical_conversation.dart';
import 'package:gpt/features/chat/domain/entities/message.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/usecases/usecases.dart';
import '../datasources/chat_local_datasources.dart';
import '../datasources/chat_remote_datasources.dart';

class ChatRepositoryImp implements ChatRepository {
  final ChatRemoteDatasources remote;
  final ChatLocalDatasources local;
  final NetworkInfo networkInfo;
  // final FlutterTts tts;

  ChatRepositoryImp({
    required this.remote,
    required this.networkInfo,
    required this.local,
    // required this.tts,
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
  Future<Either<Failure, Conversation>> changeConversation(
      PChangeConversation param) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await local.getUser();
        // Logger().i(user);
        final uid = user?.idString;
        if (uid != null) {
          final res = await remote.changeConversation(
              cat: param.category,
              uid: uid,
              conversationId: param.conversationId);
          return Right(res);
        }
        return const Left(ServerFailure(info: 'Utilisateur introuvable'));
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
      PGetResponseMessage param) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await local.getToken();
        final res = await remote.getResponseMessages(
            param.idConversation, token, param.messageId);
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, List<CategoriesBySection>>>
      fetchCategoriesBySection() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.fetchCategoriesBySection();
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, List<HistoricalConversation>>> fetchHistorical(
      PHistorical param) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await local.getUser();
        final uid = user?.idString;
        if (uid != null) {
          final res = await remote
              .fetchHistoricalConversation(param.copyWith(uid: uid));
          // Logger().w(res);
          return Right(res);
        } else {
          return const Left(ServerFailure(info: 'Utilisateur introuvalbe'));
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, Conversation>> getConversationById(
      String conversationId) async {
    if (await networkInfo.isConnected) {
      try {
        final conversation = await remote.getConversationById(conversationId);
        return Right(conversation);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getSuggestions(
      MessageParam param) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.getSuggestions(param);
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> cancelMessageComing(
      Conversation conversation) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.cancelMessage(conversation);
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  // @override
  // Future<Either<Failure, dynamic>> startReading(String message) async {
  //   try {
  //     final result = await tts.speak(message);
  //     return Right(result);
  //   } catch (_) {
  //     return const Left(CacheFailure());
  //   }
  // }

  // @override
  // Future<Either<Failure, dynamic>> stopReading() async {
  //   try {
  //     final result = await tts.stop();
  //     return Right(result);
  //   } catch (_) {
  //     return const Left(CacheFailure());
  //   }
  // }

  // @override
  // Future<Either<Failure, dynamic>> pauseReading() async {
  //   try {
  //     final result = await tts.pause();
  //     return Right(result);
  //   } catch (_) {
  //     return const Left(CacheFailure());
  //   }
  // }
}
