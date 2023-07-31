import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/widgets/custom_bubble.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';

import '../../../../../core/widgets/typing_indicator.dart';

class BottomChatLoadingWidget extends StatelessWidget {
  const BottomChatLoadingWidget({
    super.key,
    required this.lastIndex,
  });

  final int lastIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ChatBloc, ChatState>(
          buildWhen: (previous, current) =>
              previous.messages != current.messages,
          builder: (context, state) {
            return Align(
              alignment: Alignment.topRight,
              child: CustomBubbleBuilder(
                message: state.messages![lastIndex],
                context: context,
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: CustomBubble(
            color: Theme.of(context).colorScheme.onPrimary,
            padding: EdgeInsets.zero,
            nip: BubbleNip.leftBottom,
            message: const TypingIndicatorWidget(),
          ),
        ),
      ],
    );
  }
}
