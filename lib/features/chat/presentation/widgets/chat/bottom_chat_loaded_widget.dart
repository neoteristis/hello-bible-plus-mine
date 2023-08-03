import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_bubble.dart';
import '../../bloc/chat_bloc/chat_bloc.dart';
import 'suggestions.dart';

class BottomChatLoadedWidget extends StatelessWidget {
  const BottomChatLoadedWidget({
    super.key,
    required this.lastIndex,
  });

  final int lastIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.suggestionStatus != current.suggestionStatus,
      builder: (context, state) {
        return Column(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: BlocBuilder<ChatBloc, ChatState>(
                buildWhen: (previous, current) =>
                    previous.messages != current.messages,
                builder: (context, state) {
                  return CustomBubbleBuilder(
                    message: state.messages![lastIndex],
                    context: context,
                  );
                },
              ),
            ),
            BlocBuilder<ChatBloc, ChatState>(
              buildWhen: (previous, current) =>
                  previous.incoming != current.incoming,
              // ||
              // previous.containerKey != current.containerKey ||
              // previous.suggestions != current.suggestions ||
              // previous.isLoading != current.isLoading,
              builder: (context, state) {
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: CustomBubble(
                    key: state.containerKey,
                    color: Theme.of(context).colorScheme.onPrimary,
                    nip: BubbleNip.leftBottom,
                    textMessage: state.incoming,
                  ),
                );
              },
            ),
            // if (!state.isLoading!)
            const Align(
              alignment: Alignment.bottomCenter,
              child: Suggestions(),
            ),
          ],
        );
      },
    );
  }
}
