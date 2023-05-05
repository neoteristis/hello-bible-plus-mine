import 'package:bubble/bubble.dart';
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
                children: [
                  const BotAvatar(),
                  Expanded(
                    child: TypingIndicator(
                      showIndicator: true,
                      flashingCircleDarkColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            );
          case Status.loaded:
            return Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const BotAvatar(),
                  // if (!state.isTyping!)
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * .70),
                    child: Bubble(
                        radius: const Radius.circular(20.0),
                        color: Colors.white,
                        margin: const BubbleEdges.symmetric(horizontal: 0),
                        nip: BubbleNip.leftBottom,
                        child: Text(
                          state.incoming ?? '',
                          // style: TextStyle(
                          //   color: Theme.of(context).primaryColor,
                          // ),
                        )
                        // child: Markdown(
                        //   padding: EdgeInsets.zero,
                        //   shrinkWrap: true,
                        //   softLineBreak: true,
                        //   data: state.incoming ?? '',
                        // )
                        // child: TextFormField(
                        //   cursorColor: Theme.of(context).primaryColor,
                        //   enabled: false,
                        //   minLines: 1,
                        //   maxLines: null,
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyMedium
                        //       ?.copyWith(color: Theme.of(context).primaryColor),
                        //   controller: state.textEditingController,
                        //   decoration: const InputDecoration(
                        //       border: InputBorder.none,
                        //       contentPadding: EdgeInsets.zero),
                        // ),
                        ),
                  ),
                  // if (!state.isTyping!)
                  //   Expanded(child: TypingIndicator(showIndicator: true)),
                  // const Spacer(
                  //   flex: 1,
                  // ),
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
