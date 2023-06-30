import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt/l10n/function.dart';

import '../../../../../core/widgets/rounded_loading_button.dart';
import '../../bloc/social_connect_bloc/social_connect_bloc.dart';
import 'social_connect_button.dart';

class GoogleConnectButton extends StatelessWidget {
  const GoogleConnectButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialConnectBloc, SocialConnectState>(
      buildWhen: (previous, current) =>
          previous.googleBtnController != current.googleBtnController,
      builder: (context, state) {
        return SocialConnectButton(
          controller: state.googleBtnController,
          color: const Color(0xFF4285F4),
          onPressed: () {
            context
                .read<SocialConnectBloc>()
                .add(SocialConnectGoogleSubmitted());
          },
          icon: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: FittedBox(
                fit: BoxFit.none,
                child: SvgPicture.asset(
                  'assets/icons/google.svg',
                ),
              ),
            ),
          ),
          label: dict(context).continueWithGoogle,
        );
      },
    );
  }
}
