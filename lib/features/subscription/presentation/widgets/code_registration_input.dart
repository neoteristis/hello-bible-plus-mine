import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../user/presentation/bloc/registration_bloc/registration_bloc.dart';
import '../bloc/subscription_bloc.dart';

class CodeRegistrationInput extends StatelessWidget {
  const CodeRegistrationInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) =>
          previous.registrationInputs.code != current.registrationInputs.code,
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
            labelText: 'Code',
            // errorMaxLines: 2,
            // // errorText: state.registrationInputs.code.isNotValid
            // //     ? state.registrationInputs.code.displayError?.text
            // //     : null,
          ),
          onChanged: (code) => context
              .read<SubscriptionBloc>()
              .add(SubscriptionCodeChanged(code)),
        );
      },
    );
  }
}
