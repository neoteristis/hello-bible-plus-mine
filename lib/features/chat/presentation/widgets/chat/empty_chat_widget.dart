import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/features/chat/presentation/widgets/chat/suggestion_item.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/widgets/custom_bubble.dart';
import '../../../domain/entities/message_by_role.dart';
import '../../../domain/entities/text_message.dart';
import '../../bloc/chat_bloc/chat_bloc.dart';

class EmptyChatWidget extends StatelessWidget {
  const EmptyChatWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        BlocBuilder<ChatBloc, ChatState>(
          buildWhen: (previous, current) =>
              previous.incoming != current.incoming,
          builder: (context, state) {
            return Align(
              alignment: Alignment.topLeft,
              child: Container(
                constraints: const BoxConstraints(),
                child: CustomBubble(
                  indexMessage: 0,
                  textMessage: TextMessage(
                    content: state.incoming,
                    role: Role.system,
                  ),
                  color: Theme.of(context).colorScheme.onPrimary,
                  nip: BubbleNip.leftBottom,
                  message: Text(
                    state.incoming ?? '',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 17,
                      // fontSize: 15,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        BlocBuilder<ChatBloc, ChatState>(
          buildWhen: (previous, current) =>
              previous.messageStatus != current.messageStatus,
          builder: (context, state) {
            switch (state.messageStatus) {
              case Status.loaded:
                return BlocBuilder<ChatBloc, ChatState>(
                  buildWhen: (previous, current) =>
                      previous.suggestions != current.suggestions ||
                      previous.isLoading != current.isLoading ||
                      previous.maintainScroll != current.maintainScroll,
                  // ||
                  // previous.textFieldKey != current.textFieldKey,
                  builder: (context, state) {
                    final suggestions = state.suggestions;
                    if (suggestions == null ||
                        suggestions.isEmpty ||
                        state.isLoading! ||
                        state.maintainScroll!) {
                      return const SizedBox.shrink();
                    }
                    // final boxField = state.textFieldKey?.currentContext
                    //     ?.findRenderObject() as RenderBox?;
                    // double? fieldHeight = 150.0;
                    // if (boxField != null && boxField.hasSize) {
                    //   fieldHeight = boxField.size.height;
                    // }
                    return Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                        bottom: 15,
                      ),
                      margin: const EdgeInsets.only(top: 15.0),
                      // width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        border: Border(
                          top: BorderSide(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          ...suggestions.map(
                            (e) => SuggestionItem(e),
                          ),
                        ],
                      ),
                    );
                  },
                );
              default:
                return const SizedBox.shrink();
            }
          },
        )
      ],
    );
  }
}
