import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/models/required_input.dart';

import '../../bloc/registration_bloc/registration_bloc.dart';

class NameRegistrationInput extends StatelessWidget {
  const NameRegistrationInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) =>
          previous.registrationInputs.name != current.registrationInputs.name,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Nom',
            errorMaxLines: 2,
            errorText: state.registrationInputs.name.isNotValid
                ? state.registrationInputs.name.displayError?.text
                : null,
          ),
          onChanged: (username) => context
              .read<RegistrationBloc>()
              .add(RegistrationNameChanged(username)),
        );
      },
    );
  }
}
