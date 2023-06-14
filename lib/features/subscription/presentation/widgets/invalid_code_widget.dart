import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/subscription_bloc.dart';

class InvalidCodeWidget extends StatelessWidget {
  const InvalidCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        return Visibility(
          visible: state.invalidCode ?? false,
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16.0, color: Colors.black),
              children: [
                const TextSpan(
                  text:
                      'Votre code semble être incorrect. Si vous n’avez pas encore reçus votre code de validation ',
                ),
                TextSpan(
                  text: 'clique ici',
                  style: const TextStyle(
                      decoration: TextDecoration.underline, color: Colors.blue),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
