import 'package:flutter/material.dart';
import 'package:gpt/core/widgets/logo.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
import '../widgets/registrations/registrations.dart';
import 'dart:io' show Platform;

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: const Center(
                        child: Logo(
                          size: Size(54, 54),
                        ),
                      ),
                    ),
                    Text(
                      'Bonjour ! \nbienvenue sur HelloBible+',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      'Continuez pour créer votre compte ou se connecter',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    if (Platform.isIOS) AppleConnectButton(),
                    GoogleConnectButton(),
                    FacebookConnectButton(),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    'Ou continuer avec mon adresse email',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                TermsUse(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
