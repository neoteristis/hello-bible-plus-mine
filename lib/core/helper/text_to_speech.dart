import 'package:dartz/dartz.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../error/failure.dart';

class TextToSpeech {
  final FlutterTts tts;
  TextToSpeech({
    required this.tts,
  });

  Future<Either<Failure, dynamic>> startReading(String message) async {
    try {
      final result = await tts.speak(message);
      return Right(result);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }

  Future<Either<Failure, dynamic>> stopReading() async {
    try {
      final result = await tts.stop();
      return Right(result);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }

  Future<Either<Failure, dynamic>> pauseReading() async {
    try {
      final result = await tts.pause();
      return Right(result);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }

  Future<Either<Failure, dynamic>> continueReading() async {
    try {
      final result = await tts.continueHandler;
      return Right(result);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }

  Future<int?> getMaxLenghtInput() async {
    return await tts.getMaxSpeechInputLength;
  }
}
