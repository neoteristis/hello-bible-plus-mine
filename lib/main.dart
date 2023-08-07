import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'injections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await init();
  runApp(const App());
}
