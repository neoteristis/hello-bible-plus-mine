import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/widgets/rounded_loading_button.dart';
import 'social_connect_button.dart';

class GoogleConnectButton extends StatelessWidget {
  const GoogleConnectButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SocialConnectButton(
      color: Color(0xFF4285F4),
      onPressed: () {},
      icon: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: FittedBox(
            fit: BoxFit.none,
            child: SvgPicture.asset(
              'assets/icons/google.svg',
            ),
          ),
        ),
      ),
      label: 'Continuer avec Google',
    );
  }
}
