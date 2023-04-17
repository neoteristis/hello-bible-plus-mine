import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as ui;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../bloc/chat_bloc.dart';
import 'custom_drawer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    context.read<ChatBloc>().add(ChatCategoriesFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.list,
                  color: Colors.brown[400],
                  size: 30,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          centerTitle: false,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Hello',
                  style: TextStyle(color: Colors.brown[400], fontSize: 30),
                ),
                TextSpan(
                  text: 'Bible',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                      fontSize: 30),
                ),
              ],
            ),
          ),
        ),
        drawer: const CustomDrawer(),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return ui.Chat(
              messages: state.messages ?? [],
              onSendPressed: (message) {
                context.read<ChatBloc>().add(ChatMessageSent(message));
              },
              bubbleRtlAlignment: ui.BubbleRtlAlignment.right,
              bubbleBuilder: bubbleBuilder,
              emptyState: const SizedBox.shrink(),
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
              ),
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
                  style: TextStyle(),
                )
              : child,
        );
      },
    );
