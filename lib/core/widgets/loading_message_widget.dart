import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingMessageWidget extends StatelessWidget {
  const LoadingMessageWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/images/loading.json',
      // width: width ?? 100,
      // height: height ?? 20,
      fit: BoxFit.contain,
    );
  }
}
