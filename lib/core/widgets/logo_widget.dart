import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
    this.size,
  });

  final double? size;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Hello',
            style: TextStyle(
                color: Colors.white,
                fontSize: size ?? 20,
                fontWeight: FontWeight.w100),
          ),
          TextSpan(
            text: 'Bible',
            style: TextStyle(
              color: Colors.white,
              fontSize: size ?? 20,
            ),
          ),
        ],
      ),
    );
  }
}
