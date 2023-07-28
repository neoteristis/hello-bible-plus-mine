import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/widgets/logo_with_text.dart';
import 'package:gpt/features/user/presentation/bloc/auth_bloc/auth_bloc.dart';

import 'core/constants/status.dart';
import 'features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';

class SplashScreen extends StatelessWidget {
  static const String route = '/';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous.authStatus != current.authStatus,
          listener: (context, state) {
            if (state.authenticationStatus == AuthStatus.authenticated) {
              context.read<ChatBloc>().add(ChatCategoriesBySectionFetched());
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Stack(
          children: [
            Center(
              child: LogoWithText(
                logoColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'HelloBible - Copyright 2023',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
