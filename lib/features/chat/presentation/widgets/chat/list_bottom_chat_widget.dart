import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/widgets/bot_avatar.dart';
import '../../bloc/chat_bloc.dart';
import '../typing_indicator.dart';

class ListBottomChatWidget extends StatelessWidget {
  const ListBottomChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        switch (state.messageStatus) {
          case Status.loading:
            return Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  BotAvatar(),
                  Expanded(child: TypingIndicator(showIndicator: true)),
                ],
              ),
            );
          case Status.failed:
            return Center(
              child: Text(
                state.failure?.message ?? 'Une erreur s\'est produite',
                style: const TextStyle(color: Colors.red),
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
