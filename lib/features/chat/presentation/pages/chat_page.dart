import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as ui;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../bloc/chat_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Que dit la Bible?'),
        ),
        drawer: Drawer(
          child: Column(children: []),
        ),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return ui.Chat(
              showUserAvatars: true,
              messages: state.messages ?? [],
              onSendPressed: (message) {
                context.read<ChatBloc>().add(ChatMessageSent(message));
              },
              bubbleRtlAlignment: ui.BubbleRtlAlignment.right,
              bubbleBuilder: bubbleBuilder,
              emptyState: const SizedBox.shrink(),
              // theme: DefaultChatTheme(
              //   attachmentButtonIcon: null,
              //   inputTextStyle: TextStyle(fontWeight: FontWeight.normal),
              //   inputPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              //   inputBorderRadius: BorderRadius.all(Radius.circular(20)),
              //   inputContainerDecoration: BoxDecoration(
              //       border: Border.all(
              //     color: Colors.black,
              //   )),
              //   inputBackgroundColor: Colors.white,
              //   // sendButtonIcon: Icon(
              //   //   Icons.abc,
              //   //   color: Colors.white,
              //   // ),
              // ),
              user: state.sender!,
            );
          },
        ),
      ),
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
        return Bubble(
            padding: BubbleEdges.all(10),
            radius: const Radius.circular(20.0),
            color: state.sender!.id != message.author.id ||
                    message.type == types.MessageType.image
                ? const Color(0xfff5f5f7)
                : Theme.of(context).primaryColor,
            margin: nextMessageInGroup
                ? const BubbleEdges.symmetric(horizontal: 6)
                : null,
            nip: nextMessageInGroup
                ? BubbleNip.no
                : state.sender!.id != message.author.id
                    ? BubbleNip.leftBottom
                    : BubbleNip.rightBottom,
            child: message.type == types.MessageType.text
                ? Text(message.text,
                    style: TextStyle(
                      color: state.sender!.id != message.author.id ||
                              message.type == types.MessageType.image
                          ? Colors.black
                          : Colors.white,
                    ))
                : child);
      },
    );
