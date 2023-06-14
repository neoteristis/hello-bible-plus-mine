import 'package:flutter/material.dart';

class TermsUse extends StatelessWidget {
  const TermsUse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 15),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'En continuant, vous accepter nos ',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xFF223159).withOpacity(.6),
          ),
          children: [
            TextSpan(
              text: 'Conditions d\'Utilisations ',
              style: TextStyle(
                color: Color(0xFF24282E),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: 'et notre ',
            ),
            TextSpan(
              text: 'Notice Protection de vos informations personnelles',
              style: TextStyle(
                color: Color(0xFF24282E),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
