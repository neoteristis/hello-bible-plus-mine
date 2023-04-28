import 'package:flutter/material.dart';

extension StringExtension on String {
  Color get hexToColor {
    // String formattedString = "0xFF$this";
    // int colorInt = int.parse(formattedString);
    return Color(int.parse(substring(1, 7), radix: 16) + 0xFF000000);
  }
}
