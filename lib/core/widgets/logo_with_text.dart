import 'package:flutter/material.dart';

import 'logo.dart';

class LogoWithText extends StatelessWidget {
  const LogoWithText({
    super.key,
    this.logoColor,
  });

  final Color? logoColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Logo(color: logoColor),
        SizedBox(
          width: 10,
        ),
        RichText(
          text: TextSpan(
            text: 'Hello',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 31,
              color: Color(
                0xFF0C0C0C,
              ),
            ),
            children: [
              TextSpan(
                text: 'Bible +',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 31,
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
