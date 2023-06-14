import 'package:flutter/material.dart';
import '../widgets/registrations/registrations.dart';
import 'dart:io' show Platform;

import 'base_page.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      goBackSocialConnect: false,
      body: Column(
        children: [
          if (Platform.isIOS) AppleConnectButton(),
          GoogleConnectButton(),
          FacebookConnectButton(),
        ],
      ),
    );
  }
}
