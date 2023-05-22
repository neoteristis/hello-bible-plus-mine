import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Log {
  static void error(dynamic message) {
    if (kDebugMode) {
      final logger = Logger();
      logger.e(message);
    }
  }

  static void debug(dynamic message) {
    if (kDebugMode) {
      final logger = Logger();
      logger.d(message);
    }
  }

  static void info(dynamic message) {
    if (kDebugMode) {
      final logger = Logger();
      logger.i(message);
    }
  }
}
