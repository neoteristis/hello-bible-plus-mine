import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

ThemeData theme(Color? color) => ThemeData(
      fontFamily: 'SfProText',
      primaryColor: color ?? ColorConstants.primary,
      scaffoldBackgroundColor: ColorConstants.background,
      useMaterial3: true,
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: const Color(0xFF223159).withOpacity(.6),
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
