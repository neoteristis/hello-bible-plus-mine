import 'package:flutter/material.dart';

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
          text: 'En continuant, vous accepter nos ',
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
              text: 'Conditions d\'Utilisations ',
              style: style,
            ),
            TextSpan(
              text: 'et notre ',
            ),
            TextSpan(
              text: 'Notice Protection de vos informations personnelles',
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}
