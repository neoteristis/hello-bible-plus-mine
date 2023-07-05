import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String toFormattedString() {
    final String hour = this.hour.toString();
    final String minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
