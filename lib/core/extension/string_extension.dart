import 'package:flutter/material.dart';

extension StringExtension on String {
  Color get hexToColor {
    String formattedString = "0xFF$this";
    int colorInt = int.parse(formattedString);
    return Color(colorInt);
  }
}
