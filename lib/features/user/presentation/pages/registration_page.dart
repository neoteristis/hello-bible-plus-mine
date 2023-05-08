import 'package:flutter/material.dart';

import '../widgets/registration/widget_registration.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          FirstnameRegistrationInput(),
          NameRegistrationInput(),
          EmailRegistrationInput(),
          CountryRegistrationInput(),
          CodeRegistrationInput(),
          InvalidCodeWidget(),
          SubmitRegistrationButton(),
        ],
      ),
    );
  }
}
