import 'package:flutter/material.dart';
import 'package:gpt/l10n/function.dart';

class TermsUse extends StatelessWidget {
  const TermsUse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        );
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 15),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: dict(context).byContinuingYouAgreeToOur,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Theme.of(context)
                .colorScheme
                .onBackground
                .withOpacity(!isLight ? .6 : 1),
          ),
          children: [
            TextSpan(
              text: dict(context).termsOfUse,
              style: style,
            ),
            TextSpan(
              text: dict(context).andOur,
            ),
            TextSpan(
              text: dict(context).privacyNotice,
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}
