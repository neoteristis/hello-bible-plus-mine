import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/theme/theme.dart';

import 'features/chat/presentation/bloc/chat_bloc.dart';
import 'features/chat/presentation/pages/chat_page.dart';
import 'injections.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatBloc>(),
      child: BlocBuilder<ChatBloc, ChatState>(
        buildWhen: (previous, current) => previous.theme != current.theme,
        builder: (context, state) {
          return MaterialApp(
            title: 'hello bible',
            theme: state.theme ?? theme(null),
            debugShowCheckedModeBanner: false,
            home: const ChatPage(),
          );
        },
      ),
    );
  }
}
