import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/status.dart';
import '../../../../core/helper/show_dialog.dart';
import '../../../chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import '../../../container/pages/home/presentation/bloc/home_bloc.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/social_connect_bloc/social_connect_bloc.dart';
import '../widgets/registrations/registrations.dart';
import 'dart:io' show Platform;

import 'base_page.dart';

class RegistrationPage extends StatelessWidget {
  static const String route = 'registration';

  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocialConnectBloc, SocialConnectState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case Status.loaded:
            context
              ..read<AuthBloc>().add(AuthSuccessfullyLogged())
              ..read<HomeBloc>().add(ChatCategoriesBySectionFetched());
            break;
          case Status.failed:
            CustomDialog.error(context, state.failure?.message);
            break;
          default:
        }
      },
      child: BasePage(
        goBackSocialConnect: false,
        hasAppBar: false,
        body: Column(
          children: [
            if (Platform.isIOS) const AppleConnectButton(),
            const GoogleConnectButton(),
            const FacebookConnectButton(),
          ],
        ),
      ),
    );
  }
}
