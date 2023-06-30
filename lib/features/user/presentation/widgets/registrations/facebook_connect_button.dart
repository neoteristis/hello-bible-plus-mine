import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/function.dart';
import '../../bloc/social_connect_bloc/social_connect_bloc.dart';
import 'social_connect_button.dart';

class FacebookConnectButton extends StatelessWidget {
  const FacebookConnectButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialConnectBloc, SocialConnectState>(
      buildWhen: (previous, current) =>
          previous.fbBtnController != current.fbBtnController,
      builder: (context, state) {
        return SocialConnectButton(
          controller: state.fbBtnController,
          color: const Color(0xFF1877F2),
          label: dict(context).continueWithFacebook,
          icon: const Icon(
            Icons.facebook_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            context
                .read<SocialConnectBloc>()
                .add(SocialConnectFacebookSubmitted());
          },
        );
      },
    );
  }
}
