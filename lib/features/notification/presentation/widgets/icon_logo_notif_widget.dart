import 'package:flutter/material.dart';

class IconLogoNotifWidget extends StatelessWidget {
  const IconLogoNotifWidget({
    super.key,
    this.icon,
    this.color,
    this.radius,
  });

  final Widget? icon;
  final Color? color;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: radius,
      child: icon,
    );
  }
}
