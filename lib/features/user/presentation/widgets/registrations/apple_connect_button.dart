import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'social_connect_button.dart';

class AppleConnectButton extends StatelessWidget {
  const AppleConnectButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SocialConnectButton(
      color: const Color(0xFF050708),
      label: 'Continuer avec Apple',
      icon: const Icon(
        Icons.apple,
        color: Colors.white,
      ),
      onPressed: () async {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        print(credential);
        // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
        // after they have been validated with Apple (see `Integration` section for more information on how to do this)
      },
    );
  }
}
