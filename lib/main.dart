import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gpt/core/constants/color_constants.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app.dart';
import 'injections.dart';
import 'dart:io';

void main() async {
  // final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     // statusBarColor: ColorConstants.primary,
  //     systemNavigationBarColor: ColorConstants.background,
  //     // statusBarIconBrightness: Brightness.dark,
  //     systemNavigationBarIconBrightness: Brightness.dark,
  //   ),
  // );
  HttpOverrides.global = MyHttpOverrides();
  await init();
  runApp(const App());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
