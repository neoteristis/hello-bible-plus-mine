import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/unfocus_keyboard.dart';
import '../../../../../core/theme/theme.dart';
import '../../bloc/chat_bloc/chat_bloc.dart';

class SuggestionItem extends StatelessWidget {
  const SuggestionItem(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final light = isLight(context);
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) =>
          previous.scrollController != current.scrollController,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            unfocusKeyboard();
            context.read<ChatBloc>().add(
                  ChatMessageSent(
                    text,
                  ),
                );
            if (state.scrollController!.hasClients) {
              state.scrollController?.animateTo(
                state.scrollController!.position.maxScrollExtent,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: !light
                  ? Border.all(color: Theme.of(context).dividerColor, width: 1)
                  : Border.all(color: const Color(0xFFF5F5F5), width: 1),
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(
              bottom: 10,
              // left: 8,
              // right: 8,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 14,
                // fontSize: 14,
              ),
            ),
          ),
        );
      },
    );
  }
}
