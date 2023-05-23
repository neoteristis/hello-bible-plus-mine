import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/features/user/presentation/bloc/auth_bloc/auth_bloc.dart';

import '../../../../core/constants/status.dart';
import '../bloc/registration_bloc/registration_bloc.dart';
import '../widgets/registration/widget_registration.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.loaded) {
          context.read<AuthBloc>().add(AuthSuccessfullyLogged());
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
