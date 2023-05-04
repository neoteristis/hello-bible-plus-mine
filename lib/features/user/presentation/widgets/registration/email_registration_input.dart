import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/features/user/data/models/email_input.dart';

import '../../bloc/registration_bloc/registration_bloc.dart';

class EmailRegistrationInput extends StatelessWidget {
  const EmailRegistrationInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) =>
          previous.registrationInputs.email != current.registrationInputs.email,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
            errorMaxLines: 2,
            errorText: state.registrationInputs.email.isNotValid
                ? state.registrationInputs.email.displayError!.text
                : null,
          ),
          onChanged: (email) => context
              .read<RegistrationBloc>()
              .add(RegistrationEmailChanged(email)),
        );
      },
    );
  }
}
