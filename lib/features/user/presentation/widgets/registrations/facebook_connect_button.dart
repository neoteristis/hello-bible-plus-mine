import 'package:flutter/material.dart';

import 'social_connect_button.dart';

class FacebookConnectButton extends StatelessWidget {
  const FacebookConnectButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SocialConnectButton(
      color: Color(0xFF1877F2),
      label: 'Continuer avec Facebook',
      icon: Icon(
        Icons.facebook_rounded,
        color: Colors.white,
      ),
      onPressed: () {},
    );
  }
}
