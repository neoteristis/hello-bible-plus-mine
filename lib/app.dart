import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/chat/presentation/bloc/chat_bloc.dart';
import 'features/chat/presentation/pages/chat_page.dart';
import 'injections.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatBloc>(),
      child: MaterialApp(
        title: 'hello bible',
        theme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor: Colors.brown[400],
            scaffoldBackgroundColor: Color(0xFFF8F4F1)),
        debugShowCheckedModeBanner: false,
        home: ChatPage(),
      ),
    );
  }
}
