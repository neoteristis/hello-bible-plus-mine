import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

const primaryColor = Color(0xFF22B573);

ThemeData theme(Color? color) => ThemeData(
      fontFamily: 'SfProText',
      primaryColor:
          // color ??
          primaryColor,
      iconTheme: const IconThemeData(color: primaryColor),
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
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black, //<-- SEE HERE
  ),
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
    errorStyle: TextStyle(color: Colors.white),
    filled: true,
    fillColor: const Color(0xFFF3F5F7),
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
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
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
