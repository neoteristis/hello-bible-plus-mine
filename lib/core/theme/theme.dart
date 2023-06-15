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
        headlineLarge: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 20,
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
    );
