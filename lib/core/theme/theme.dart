import 'package:flutter/material.dart';

const primaryColor = Color(0xFF22B573);

final bodyLarge = TextStyle(
  color: const Color(0xFF223159).withOpacity(.6),
  fontSize: 16,
);

const titleMedium = TextStyle(
  color: Colors.black, // <-- TextFormField input color
);
const headlineLarge = TextStyle(
  fontWeight: FontWeight.w800,
  fontSize: 20,
  color: Color(0xFF101520),
);
const headlineMedium = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 31,
  color: Color(
    0xFF0C0C0C,
  ),
);
const labelLarge = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 14,
  color: Color(
    0xFF223159,
  ),
);

ThemeData light = ThemeData(
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
  fontFamily: 'SfProText',
  dividerColor: const Color(0xFFE3E6E8),
  dividerTheme: const DividerThemeData(color: Color(0xFFE3E6E8)),
  primaryColor: primaryColor,
  timePickerTheme: const TimePickerThemeData(
    dayPeriodShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
      side: BorderSide.none,
    ),
    helpTextStyle: TextStyle(color: Colors.black),
    backgroundColor: Colors.white,
    dialTextStyle: TextStyle(color: Colors.black),
    hourMinuteShape: RoundedRectangleBorder(
      side: BorderSide(),
      borderRadius: BorderRadius.all(
        Radius.circular(4.0),
      ),
    ),
    hourMinuteColor: Colors.grey,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black),
      helperStyle: TextStyle(color: Colors.black),
      filled: true,
      fillColor: Colors.grey,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(color: Colors.black)),
      contentPadding: EdgeInsets.all(0),
    ),
  ),
  dialogBackgroundColor: Colors.white,
  dialogTheme: const DialogTheme(backgroundColor: Colors.white),
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
    bodyLarge: bodyLarge.copyWith(
      color: const Color(0xFF223159).withOpacity(.6),
    ),
    titleMedium: titleMedium.copyWith(
      color: Colors.black, // <-- TextFormField input color
    ),
    headlineLarge: headlineLarge.copyWith(
      color: const Color(0xFF101520),
    ),
    headlineMedium: headlineMedium.copyWith(
      color: const Color(
        0xFF0C0C0C,
      ),
    ),
    labelLarge: labelLarge.copyWith(
      color: const Color(
        0xFF223159,
      ),
    ),
  ),
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
  primaryColor: primaryColor,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black, //<-- SEE HERE
  ),
  dialogBackgroundColor: const Color(0xFF101520),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF101520),
    contentTextStyle: TextStyle(color: Colors.white),
  ),
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
  textTheme: TextTheme(
    bodyLarge: bodyLarge.copyWith(
      color: const Color(0xFFB6B6B6),
    ),
    headlineLarge: headlineLarge.copyWith(
      color: const Color(0xFFEFEFEF),
    ),
    labelLarge: labelLarge.copyWith(
      color: Colors.white,
    ),
    headlineMedium: headlineMedium.copyWith(),
    titleMedium: titleMedium.copyWith(
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.white,
    onPrimary: const Color(0xFF0D0D0D),
    secondary: const Color(0xFFEFEFEF),
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
