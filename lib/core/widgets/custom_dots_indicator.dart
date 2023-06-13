import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class CustomDotsIndicator extends StatelessWidget {
  const CustomDotsIndicator({
    super.key,
    this.position = 0,
    this.dotsCount = 3,
  });

  final int position;
  final int? dotsCount;

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: dotsCount ?? 3,
      position: position,
      decorator: const DotsDecorator(
        color: Color(0xFFE4E6E8), // Inactive color
        activeColor: Color(0xFF22B573),
        size: Size(7, 7),
        activeSize: Size(7, 7),
      ),
    );
  }
}
