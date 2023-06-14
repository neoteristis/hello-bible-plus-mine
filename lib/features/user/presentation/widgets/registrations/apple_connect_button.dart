import 'package:flutter/material.dart';

import 'social_connect_button.dart';

class AppleConnectButton extends StatelessWidget {
  const AppleConnectButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SocialConnectButton(
      color: Color(0xFF050708),
      label: 'Continuer avec Apple',
      icon: Icon(
        Icons.apple,
        color: Colors.white,
      ),
      onPressed: () {},
    );
  }
}
