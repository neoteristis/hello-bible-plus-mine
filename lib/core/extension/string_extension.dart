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

  /// Checks if string is phone number.
  bool get isPhoneNumber {
    if (length > 16 || length < 9) {
      return false;
    }
    return hasMatch(this, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  bool get hasUnclosedParenthesis {
    final int openingCount = split('(').length - 1;
    final int closingCount = split(')').length - 1;

    if (openingCount > closingCount) {
      final RegExp regex = RegExp(r'\([^)]*$');
      final Iterable<Match> matches = regex.allMatches(this);

      if (matches.isNotEmpty) {
        return true;
      }
    }

    return false;
  }

  bool get hasUnclosedQuote {
    final int openingCount = split('"').length - 1;

    if (openingCount % 2 != 0) {
      return true;
    }

    return false;
  }

  bool get hasUnclosedSquareBracket {
    final int openingCount = split('[').length - 1;
    final int closingCount = split(']').length - 1;

    if (openingCount > closingCount) {
      final RegExp regex = RegExp(r'\[[^\[\]]*$');
      final Iterable<Match> matches = regex.allMatches(this);

      if (matches.isNotEmpty) {
        return true;
      }
    }

    return false;
  }

  bool get hasUnclosedCurlyBrace {
    final int openingCount = split('{').length - 1;
    final int closingCount = split('}').length - 1;

    if (openingCount > closingCount) {
      final RegExp regex = RegExp(r'{[^{}]*$');
      final Iterable<Match> matches = regex.allMatches(this);

      if (matches.isNotEmpty) {
        return true;
      }
    }

    return false;
  }
}

bool hasMatch(String? value, String pattern) {
  return (value == null) ? false : RegExp(pattern).hasMatch(value);
}
