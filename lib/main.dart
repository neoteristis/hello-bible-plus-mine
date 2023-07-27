import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'injections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await init();
  runApp(const App());
}
  // final WidgetsBinding widgetsBinding =
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     // statusBarColor: ColorConstants.primary,
  //     systemNavigationBarColor: ColorConstants.background,
  //     // statusBarIconBrightness: Brightness.dark,
  //     systemNavigationBarIconBrightness: Brightness.dark,
  //   ),
  // );
  // HttpOverrides.global = MyHttpOverrides();

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }