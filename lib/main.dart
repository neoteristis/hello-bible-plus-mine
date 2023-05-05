import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpt/core/constants/color_constants.dart';

import 'app.dart';
import 'injections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
