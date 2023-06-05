import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/features/chat/presentation/bloc/historical_bloc/historical_bloc.dart';
import 'package:gpt/features/user/presentation/bloc/auth_bloc/auth_bloc.dart';

import 'core/constants/status.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ChatBloc, ChatState>(
          listenWhen: (previous, current) =>
              previous.catStatus != current.catStatus,
          listener: (context, state) {
            if ((state.catStatus == Status.loaded ||
                state.catStatus == Status.failed)) {
              context.read<AuthBloc>().add(AuthSuccessfullyLogged());
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous.authStatus != current.authStatus,
          listener: (context, state) {
            if (state.authStatus == Status.loaded) {
              context.read<ChatBloc>().add(ChatCategoriesBySectionFetched());
              context.read<HistoricalBloc>().add(HistoricalFetched());
            }
          },
        ),
      ],
      child: const Scaffold(
        body: Center(
          child: Text('Splash Screen'),
        ),
      ),
    );
  }
}
