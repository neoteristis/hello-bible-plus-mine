import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/rounded_loading_button.dart';
import '../bloc/subscription_bloc.dart';

class CheckCodeButton extends StatelessWidget {
  const CheckCodeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      buildWhen: (previous, current) =>
          previous.buttonController != current.buttonController,
      builder: (context, state) {
        return RoundedLoadingButton(
          animateOnTap: false,
          controller: RoundedLoadingButtonController(),
          onPressed: () {
            context.read<SubscriptionBloc>().add(SubscriptionCodeChecked());
          },
          child: const Text('valider'),
        );
      },
    );
  }
}
