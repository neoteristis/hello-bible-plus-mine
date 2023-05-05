import 'package:flutter/material.dart';

extension StringExtension on String {
  Color get hexToColor {
    return Color(int.parse(substring(1, 7), radix: 16) + 0xFF000000);
  }

  String get capitalize {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Checks if string is email.
  bool get isEmail => hasMatch(this,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
}

bool hasMatch(String? value, String pattern) {
  return (value == null) ? false : RegExp(pattern).hasMatch(value);
}
