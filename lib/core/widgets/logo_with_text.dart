import 'package:flutter/material.dart';

import 'logo.dart';

class LogoWithText extends StatelessWidget {
  const LogoWithText({
    super.key,
    this.logoColor,
    this.textColor,
    this.logoSize,
    this.textSize,
    this.center = true,
  });

  final Color? logoColor;
  final Color? textColor;
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
        const SizedBox(
          width: 10,
        ),
        RichText(
          text: TextSpan(
            text: 'Hello',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: textSize,
                  color: textColor,
                ),
            children: [
              TextSpan(
                text: 'Bible',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: textSize,
                      wordSpacing: -2.5,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
