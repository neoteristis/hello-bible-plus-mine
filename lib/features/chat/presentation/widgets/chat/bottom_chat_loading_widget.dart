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
              child: customBubbleBuilder(
                message: state.messages![lastIndex],
                context: context,
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: BlocBuilder<ChatBloc, ChatState>(
            buildWhen: (previous, current) =>
                previous.textFieldKey != current.textFieldKey,
            builder: (context, state) {
              final boxField = state.textFieldKey?.currentContext
                  ?.findRenderObject() as RenderBox?;
              double? fieldHeight = 0.0;
              if (boxField != null && boxField.hasSize) {
                fieldHeight = boxField.size.height;
              }
              return Padding(
                padding: EdgeInsets.only(bottom: fieldHeight),
                child: CustomBubble(
                  color: Theme.of(context).colorScheme.onPrimary,
                  padding: EdgeInsets.zero,
                  nip: BubbleNip.leftBottom,
                  message: const TypingIndicatorWidget(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
