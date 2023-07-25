part of 'theme.dart';

ThemeData light = ThemeData(
  canvasColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'SfProText',
  dividerColor: const Color(0xFFE3E6E8),
  dividerTheme: const DividerThemeData(
    color: Color(0xFFE3E6E8),
  ),
  primaryColor: primaryColor,
  useMaterial3: true,
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
    surface: Colors.white,
    // surface: Colors.black,
    onSurface: const Color(0xFF24282E),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
  ),
  timePickerTheme: const TimePickerThemeData(
    dayPeriodShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
      side: BorderSide.none,
    ),
    helpTextStyle: TextStyle(
      color: Colors.black,
    ),
    backgroundColor: Colors.white,
    dialTextStyle: TextStyle(
      color: Colors.black,
    ),
    hourMinuteShape: RoundedRectangleBorder(
      side: BorderSide(),
      borderRadius: BorderRadius.all(
        Radius.circular(4.0),
      ),
    ),
    hourMinuteColor: Colors.grey,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      helperStyle: TextStyle(
        color: Colors.black,
      ),
      filled: true,
      fillColor: Colors.grey,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(color: Colors.black),
      ),
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
  textTheme: TextTheme(
    bodyLarge: bodyLarge.copyWith(
      color: const Color(0xFF223159).withOpacity(.6),
    ),
    // bodyMedium: ,
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
    titleSmall: titleSmall.copyWith(
      color: const Color(0xFF0C0C0C),
    ),
    labelSmall: labelSmall.copyWith(
      color: const Color(0xFF101520),
    ),
  ),
);
