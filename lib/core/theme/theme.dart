import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

ThemeData theme(Color? color) => ThemeData(
      fontFamily: 'SfProText',
      primaryColor: color ?? ColorConstants.primary,
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
        fillColor: Color(0xFFF3F5F7),
      ),
      // scaffoldBackgroundColor: ColorConstants.background,
      useMaterial3: true,
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: const Color(0xFF223159).withOpacity(.6),
          fontSize: 16,
        ),
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Color(
            0xFF223159,
          ),
        ),
      ),
    );
