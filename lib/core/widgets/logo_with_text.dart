import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        const SizedBox(
          width: 10,
        ),
        RichText(
          text: TextSpan(
            text: 'Hello',
            // style: Theme.of(context).textTheme.,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: textSize?.sp,

                  // fontWeight: FontWeight.w500,
                  // color: Color(
                  //   0xFF0C0C0C,
                  // ),
                ),
            // style: TextStyle(
            //   fontWeight: FontWeight.w500,
            //   fontSize: textSize?.sp ?? 31.sp,
            //   // fontSize: textSize ?? 31,
            //   color: Theme.of(context).colorScheme.tertiary,
            // ),
            children: [
              TextSpan(
                text: 'Bible +',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: textSize?.sp,
                      wordSpacing: -2.5,
                      fontWeight: FontWeight.w800,
                      // fontWeight: FontWeight.w500,
                      // color: Color(
                      //   0xFF0C0C0C,
                      // ),
                    ),
                // style: TextStyle(
                //   fontWeight: FontWeight.w800,
                //   fontSize: textSize?.sp ?? 31.sp,
                //   // fontSize: textSize ?? 31,
                //   wordSpacing: -2.5,
                //   color: Theme.of(context).colorScheme.tertiary,
                // ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
