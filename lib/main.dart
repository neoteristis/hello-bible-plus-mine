import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpt/core/constants/color_constants.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app.dart';
import 'injections.dart';

void main() async {
  // final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // statusBarColor: ColorConstants.primary,
      systemNavigationBarColor: ColorConstants.background,
      // statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await init();
  runApp(const App());
}
