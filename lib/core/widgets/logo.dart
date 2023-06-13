import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    this.color,
    this.size,
  });

  final Color? color;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/logo.svg',
      color: color,
      width: size?.width,
      height: size?.height,
    );
  }
}
