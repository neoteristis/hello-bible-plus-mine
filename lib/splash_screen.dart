import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/widgets/logo_with_text.dart';
import 'package:gpt/features/user/presentation/bloc/auth_bloc/auth_bloc.dart';

import 'core/constants/status.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return MultiBlocListener(
      listeners: [
        // BlocListener<ChatBloc, ChatState>(
        //   listenWhen: (previous, current) =>
        //       previous.catStatus != current.catStatus,
        //   listener: (context, state) {
        //     if ((state.catStatus == Status.loaded ||
        //         state.catStatus == Status.failed)) {
        //       context.read<AuthBloc>().add(AuthSuccessfullyLogged());
        //     }
        //   },
        // ),
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous.authStatus != current.authStatus,
          listener: (context, state) {
            if (state.authStatus == Status.loaded) {
              context.read<ChatBloc>().add(ChatCategoriesBySectionFetched());
              // context.read<HistoricalBloc>().add(HistoricalFetched());
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: !isLight
            ? Theme.of(context).primaryColor
            : Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            Center(
              child: LogoWithText(
                logoColor:
                    !isLight ? Colors.white : Theme.of(context).primaryColor,
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
                        'HelloBible+ - Copyright 2023',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: !isLight ? Colors.white : Colors.black),
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
