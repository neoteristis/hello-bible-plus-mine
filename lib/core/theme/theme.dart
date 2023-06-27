import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

const primaryColor = Color(0xFF22B573);

ThemeData light = ThemeData(
  fontFamily: 'SfProText',
  dividerColor: const Color(0xFFE3E6E8),
  dividerTheme: const DividerThemeData(color: Color(0xFFE3E6E8)),
  primaryColor:
      // color ??
      primaryColor,
  dialogBackgroundColor: Colors.white,
  dialogTheme: DialogTheme(backgroundColor: Colors.white),
  iconTheme: const IconThemeData(color: primaryColor),
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: const Color(0xFF223159),
    suffixIconColor: const Color(0xFF223159),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    ),
    filled: true,
    fillColor: const Color(0xFFF3F5F7),
  ),
  // scaffoldBackgroundColor: ColorConstants.background,
  useMaterial3: true,
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: const Color(0xFF223159).withOpacity(.6),
      fontSize: 16,
    ),
    // bodyMedium: TextStyle(
    //   color: Colors.white,
    //   fontWeight: FontWeight.w600,
    //   fontSize: 14,
    // ),
    headlineLarge: const TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 20,
      color: Color(0xFF101520),
    ),
    headlineMedium: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 31,
      color: Color(
        0xFF0C0C0C,
      ),
    ),
    labelLarge: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: Color(
        0xFF223159,
      ),
    ),
  ),
  // 0xFF050708
  scaffoldBackgroundColor: Colors.white,
  // dividerColor: const Color(0xFFE3E6E8),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: Colors.white,
    secondary: const Color(0xFF101520),
    onSecondary: const Color(0xFF223159).withOpacity(0.6),
    tertiary: const Color(0xFF0C0C0C),
    error: Colors.red,
    onError: Colors.white,
    background: const Color(0xFFF3F5F7),
    onBackground: const Color(0xFF223159),
    surface: Colors.black,
    onSurface: const Color(0xFF24282E),
  ),
);

ThemeData dark = ThemeData(
  primaryColor:
      // color ??
      primaryColor,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black, //<-- SEE HERE
  ),
  dialogBackgroundColor: Color(0xFF101520),
  dialogTheme: DialogTheme(
      backgroundColor: Color(0xFF101520),
      contentTextStyle: TextStyle(color: Colors.white)),
  dividerColor: const Color(0xFF22272A),
  dividerTheme: const DividerThemeData(color: Color(0xFF22272A)),
  scaffoldBackgroundColor: const Color(0xFF101520),
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: const Color(0xFF223159),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    ),
    errorStyle: const TextStyle(color: Colors.white),
    filled: true,
    fillColor: const Color(0xFF0D0D0D),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Color(0xFFB6B6B6),
      fontSize: 16,
    ),
    // bodyMedium: TextStyle(
    //   color: Colors.white,
    //   fontWeight: FontWeight.w600,
    //   fontSize: 14,
    // ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 20,
      color: Color(0xFFEFEFEF),
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: Colors.white,
    ),
    headlineMedium: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 31,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.white,
    onPrimary: Color(0xFF0D0D0D),
    secondary: Color(0xFFEFEFEF),
    onSecondary: const Color(0xFFB6B6B6).withOpacity(0.6),
    tertiary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: const Color(0xFF101520),
    onBackground: const Color(0xFFF3F5F9),
    surface: Colors.black,
    onSurface: const Color(0xFFD1D5DB),
  ),
);

bool isLight(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark;
