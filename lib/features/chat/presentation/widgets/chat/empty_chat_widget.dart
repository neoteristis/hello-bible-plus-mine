import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/log.dart';
import '../../../../../core/widgets/custom_bubble.dart';
import '../../bloc/chat_bloc/chat_bloc.dart';
import 'suggestions.dart';

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
                  textMessage: state.incoming,
                  color: Theme.of(context).colorScheme.onPrimary,
                  nip: BubbleNip.leftBottom,
                ),
              ),
            );
          },
        ),

        BlocBuilder<ChatBloc, ChatState>(
          buildWhen: (previous, current) =>
              previous.conversation != current.conversation,
          builder: (context, state) {
            final showFirstSuggestions =
                state.conversation?.category?.showFirstSuggestions;
            final hasSuggestions = state.conversation?.category?.hasSuggestions;
            if (showFirstSuggestions != null &&
                hasSuggestions != null &&
                showFirstSuggestions &&
                hasSuggestions) {
              Log.info('show first suggestions');
              return const Suggestions();
            }
            return const SizedBox.shrink();
          },
        ),
        // BlocBuilder<ChatBloc, ChatState>(
        //   // buildWhen: (previous, current) =>
        //   //     previous.messageStatus != current.messageStatus,
        //   builder: (context, state) {
        //     return const Suggestions();
        //     // switch (state.messageStatus) {
        //     //   case Status.loaded:
        //     //     return const Suggestions();
        //     //   default:
        //     //     return const SizedBox.shrink();
        //     // }
        //   },
        // )
      ],
    );
  }
}
