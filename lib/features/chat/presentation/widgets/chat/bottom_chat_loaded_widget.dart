import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gpt/features/chat/presentation/widgets/chat/suggestion_item.dart';

import '../../../../../core/widgets/custom_bubble.dart';
import '../../../domain/entities/message_by_role.dart';
import '../../../domain/entities/text_message.dart';
import '../../bloc/chat_bloc/chat_bloc.dart';

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
          previous.textFieldKey != current.textFieldKey,
      builder: (context, state) {
        final boxField = state.textFieldKey?.currentContext?.findRenderObject()
        as RenderBox?;
        double? fieldHeight = 0.0;
        if (boxField != null && boxField.hasSize) {
          fieldHeight = boxField.size.height;
        }
        return Column(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: BlocBuilder<ChatBloc, ChatState>(
                buildWhen: (previous, current) =>
                previous.messages != current.messages,
                builder: (context, state) {
                  return customBubbleBuilder(
                    message: state.messages![lastIndex],
                    context: context,
                  );
                },
              ),
            ),
            BlocBuilder<ChatBloc, ChatState>(
              buildWhen: (previous, current) =>
              previous.incoming != current.incoming ||
                  previous.containerKey != current.containerKey ||
                  previous.suggestions != current.suggestions ||
                  previous.isLoading != current.isLoading,
              builder: (context, state) {
                final suggestions = state.suggestions;
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: suggestions == null ||
                          suggestions.isEmpty ||
                          state.isLoading!
                          ? fieldHeight ?? 0
                          : 0,
                    ),
                    child: CustomBubble(
                      key: state.containerKey,
                      color: Theme.of(context).colorScheme.onPrimary,
                      nip: BubbleNip.leftBottom,
                      textMessage: TextMessage(
                        content: state.incoming,
                        role: Role.system,
                      ),
                      message: Text(
                        state.incoming ?? '',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 17.sp,
                          // fontSize: 17,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            if (!state.isLoading!)
              Align(
                alignment: Alignment.bottomCenter,
                child: BlocBuilder<ChatBloc, ChatState>(
                  buildWhen: (previous, current) =>
                  previous.suggestions != current.suggestions,
                  builder: (context, state) {
                    final suggestions = state.suggestions;
                    if (suggestions == null || suggestions.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                        bottom: fieldHeight ?? 0,
                      ),
                      margin: const EdgeInsets.only(top: 15.0),
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
                ),
              ),
          ],
        );
      },
    );
  }
}