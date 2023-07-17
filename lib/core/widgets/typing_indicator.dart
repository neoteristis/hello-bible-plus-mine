import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TypingIndicatorWidget extends StatelessWidget {
  const TypingIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/lotties/typing_indicator.json',
        width: 50, height: 40, fit: BoxFit.contain);
  }
}
