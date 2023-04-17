import 'package:flutter/material.dart';

import 'app.dart';
import 'injections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const App());
}
