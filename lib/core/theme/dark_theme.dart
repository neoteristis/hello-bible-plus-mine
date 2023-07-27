part of 'theme.dart';

ThemeData dark = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'SfProText',
  dividerColor: const Color(0xFF22272A),
  dividerTheme: const DividerThemeData(
    color: Color(0xFF22272A),
  ),
  primaryColor: primaryColor,
  useMaterial3: true,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: primaryColor,
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
  scaffoldBackgroundColor: const Color(0xFF101520),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
  ),
  dialogBackgroundColor: const Color(0xFF101520),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF101520),
    contentTextStyle: TextStyle(color: Colors.white),
  ),
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
    errorStyle: const TextStyle(
      color: Colors.white,
    ),
    filled: true,
    fillColor: const Color(0xFF0D0D0D),
  ),
  // bottomSheetTheme: const BottomSheetThemeData(
  //   backgroundColor: Color(0xFF101520),
  //   modalBackgroundColor: Color(0xFF101520),
  //   surfaceTintColor: Color(0xFF101520),
  // ),
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
    labelMedium: labelMedium.copyWith(
      color: const Color(0xFF646F8B),
    ),
    headlineMedium: headlineMedium.copyWith(
      color: Colors.white,
    ),
    titleMedium: titleMedium.copyWith(
      color: Colors.white,
    ),
    titleSmall: titleSmall.copyWith(
      color: Colors.white,
    ),
    labelSmall: labelSmall.copyWith(
      color: const Color(0xFFEFEFEF),
    ),
  ),
);
