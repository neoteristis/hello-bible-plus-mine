import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/features/user/presentation/bloc/social_connect_bloc/social_connect_bloc.dart';
import 'package:gpt/l10n/function.dart';

import 'social_connect_button.dart';

class AppleConnectButton extends StatelessWidget {
  const AppleConnectButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialConnectBloc, SocialConnectState>(
      buildWhen: (previous, current) =>
          previous.appleBtnController != current.appleBtnController,
      builder: (context, state) {
        return SocialConnectButton(
          color: Theme.of(context).colorScheme.onPrimary,
          label: dict(context).continueWithApple,
          controller: state.appleBtnController,
          labelColor: Theme.of(context).colorScheme.tertiary,
          valueColor: Theme.of(context).colorScheme.tertiary,
          icon: Icon(
            Icons.apple,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          onPressed: () {
            context
                .read<SocialConnectBloc>()
                .add(SocialConnectAppleSubmitted());
          },
        );
      },
    );
  }
}
