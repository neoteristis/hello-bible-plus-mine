import 'package:flutter/material.dart';

class CustomBubble extends StatelessWidget {
  const CustomBubble(
      {super.key,
      required this.message,
      this.nip = BubbleNip.no,
      // this.textColor = Colors.black,
      this.color = Colors.white,
      this.radius = 20.0});

  final Widget message;
  final BubbleNip? nip;
  final Color? color;
  // final Color? textColor;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry? borderRadius;

    switch (nip) {
      case BubbleNip.leftBottom:
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(
            radius!,
          ),
          topRight: Radius.circular(
            radius!,
          ),
          bottomRight: Radius.circular(
            radius!,
          ),
        );
        break;
      case BubbleNip.rightBottom:
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(
            radius!,
          ),
          topRight: Radius.circular(
            radius!,
          ),
          bottomLeft: Radius.circular(
            radius!,
          ),
        );
        break;
      default:
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(
            radius!,
          ),
          topRight: Radius.circular(
            radius!,
          ),
          bottomLeft: Radius.circular(
            radius!,
          ),
          bottomRight: Radius.circular(
            radius!,
          ),
        );
    }
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000)
                .withOpacity(0.1), // shadow color with opacity
            spreadRadius: 0, // spread radius
            blurRadius: 10, // blur radius
            offset: const Offset(0, 4), // offset in x and y direction
          ),
        ],
        color: color,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: message,
      ),
    );
  }
}

enum BubbleNip {
  no,
  leftBottom,
  rightBottom,
}
