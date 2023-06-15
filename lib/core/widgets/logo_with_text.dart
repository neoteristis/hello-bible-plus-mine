import 'package:flutter/material.dart';

import 'logo.dart';

class LogoWithText extends StatelessWidget {
  const LogoWithText({
    super.key,
    this.logoColor,
    this.logoSize,
    this.textSize,
    this.center = true,
  });

  final Color? logoColor;
  final Size? logoSize;
  final double? textSize;
  final bool? center;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          center! ? MainAxisAlignment.center : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Logo(
          color: logoColor,
          size: logoSize,
        ),
        SizedBox(
          width: 10,
        ),
        RichText(
          text: TextSpan(
            text: 'Hello',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: textSize ?? 31,
              color: Color(
                0xFF0C0C0C,
              ),
            ),
            children: [
              TextSpan(
                text: 'Bible +',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: textSize ?? 31,
                  wordSpacing: -2.5,
                  color: Color(
                    0xFF0C0C0C,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
