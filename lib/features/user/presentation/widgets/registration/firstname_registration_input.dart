import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/models/required_input.dart';

import '../../bloc/registration_bloc/registration_bloc.dart';

class FirstnameRegistrationInput extends StatelessWidget {
  const FirstnameRegistrationInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) =>
          previous.registrationInputs.firstname !=
          current.registrationInputs.firstname,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Prénom',
            errorMaxLines: 2,
            errorText: state.registrationInputs.firstname.isNotValid
                ? state.registrationInputs.firstname.displayError!.text
                : null,
          ),
          onChanged: (firstname) => context
              .read<RegistrationBloc>()
              .add(RegistrationFirstnameChanged(firstname)),
        );
      },
    );
  }
}
