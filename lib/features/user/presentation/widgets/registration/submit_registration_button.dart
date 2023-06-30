import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/features/user/presentation/bloc/registration_bloc/registration_bloc.dart';

import '../../../../../core/widgets/rounded_loading_button.dart';

class SubmitRegistrationButton extends StatelessWidget {
  const SubmitRegistrationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) =>
          previous.registrationBtnController !=
          current.registrationBtnController,
      builder: (context, state) {
        return RoundedLoadingButton(
          animateOnTap: false,
          controller: state.registrationBtnController ??
              RoundedLoadingButtonController(),
          onPressed: () {
            context
                .read<RegistrationBloc>()
                .add(RegistrationSubmitted(context));
          },
          child: const Text('Valider'),
        );
      },
    );
  }
}
