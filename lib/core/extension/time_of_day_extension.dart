import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String get toFormattedString {
    final String hour = this.hour.toString();
    final String minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  DateTime get toDateTime {
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
  }
}
