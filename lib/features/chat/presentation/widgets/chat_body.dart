import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart' as ui;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gpt/features/chat/presentation/widgets/categories_widget.dart';
import 'package:gpt/features/chat/presentation/widgets/typing_indicator.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/widgets/bot_avatar.dart';
import '../bloc/chat_bloc.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        switch (state.conversationStatus) {
          case Status.loading:
            return Center(
              child: CircularProgressIndicator(
                color: Colors.brown[400],
              ),
            );
          case Status.loaded:
            return ui.Chat(
              showUserAvatars: true,
              avatarBuilder: (uid) => BotAvatar(),
              messages: state.messages ?? [],
              onSendPressed: (message) {
                context.read<ChatBloc>().add(ChatMessageSent(message));
              },
              bubbleRtlAlignment: ui.BubbleRtlAlignment.right,
              bubbleBuilder: bubbleBuilder,
              emptyState: Center(
                child: Text(
                  'Vous pouvez commencer une conversation',
                  style: TextStyle(color: Colors.brown[400]),
                ),
              ),
              disableImageGallery: true,
              theme: ui.DefaultChatTheme(
                attachmentButtonMargin: const EdgeInsets.all(0),
                attachmentButtonIcon: Container(),
                documentIcon: Container(),
                inputMargin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                inputBackgroundColor: Colors.white,
                inputTextColor: Colors.black,
                inputPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                inputContainerDecoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                dateDividerTextStyle: TextStyle(
                  color: Colors.black26,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  height: 1.333,
                ),
              ),
              user: state.sender!,
              listBottomWidget: state.messageStatus == Status.loading
                  ? Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          BotAvatar(),
                          Expanded(child: TypingIndicator(showIndicator: true)),
                        ],
                      ),
                    )
                  : state.messageStatus == Status.failed
                      ? Center(
                          child: Text(
                            state.failure?.message ??
                                'Une erreur s\'est produite',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : null,
              scrollPhysics: BouncingScrollPhysics(),
            );
          case Status.failed:
            return const CategoriesWidget(
              isWhite: true,
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

Widget bubbleBuilder(
  Widget child, {
  required message,
  required nextMessageInGroup,
}) =>
    BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        // if (state.messageStatus == Status.loading) {
        //   return Bubble(
        //     // Show loading bubble
        //     color: Colors.grey[300],
        //     child: SizedBox(
        //       width: 24,
        //       height: 24,
        //       child: Text('loading'),
        //     ),
        //   );
        // }
        return Bubble(
          radius: const Radius.circular(20.0),
          color: state.sender!.id != message.author.id ||
                  message.type == types.MessageType.image
              ? Colors.white
              : Colors.brown[400],
          margin: nextMessageInGroup
              ? const BubbleEdges.symmetric(horizontal: 6)
              : null,
          nip: nextMessageInGroup
              ? BubbleNip.no
              : state.sender!.id != message.author.id
                  ? BubbleNip.leftBottom
                  : BubbleNip.rightBottom,
          child: message.type == types.MessageType.text
              ? Text(
                  message.text,
                  style: TextStyle(
                    color: state.sender!.id != message.author.id ||
                            message.type == types.MessageType.image
                        ? Color(0xFF8D6E63)
                        : Colors.white,
                  ),
                )
              : child,
        );
      },
    );
