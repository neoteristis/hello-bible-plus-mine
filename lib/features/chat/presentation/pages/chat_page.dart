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
        drawer: Drawer(
          child: ListView(children: [
            DrawerHeader(
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Hello',
                        style:
                            TextStyle(color: Colors.brown[400], fontSize: 40),
                      ),
                      TextSpan(
                        text: 'Bible',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[900],
                            fontSize: 40),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const ListTile(
              title: Text('Que dit la Bible ?'),
            ),
            const ListTile(
              title: Text('Que dirait Jésus ?'),
            ),
            const ListTile(
              title: Text('Comment prier ?'),
            )
          ]),
        ),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return ui.Chat(
              messages: state.messages ?? [],
              onSendPressed: (message) {
                context.read<ChatBloc>().add(ChatMessageSent(message));
              },
              bubbleRtlAlignment: ui.BubbleRtlAlignment.right,
              bubbleBuilder: bubbleBuilder,
              emptyState: SizedBox.shrink(),
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
          radius: const Radius.circular(20.0),
          color: state.sender!.id != message.author.id ||
                  message.type == types.MessageType.image
              ? const Color(0xfff5f5f7)
              : Colors.blue,
          margin: nextMessageInGroup
              ? const BubbleEdges.symmetric(horizontal: 6)
              : null,
          nip: nextMessageInGroup
              ? BubbleNip.no
              : state.sender!.id != message.author.id
                  ? BubbleNip.leftBottom
                  : BubbleNip.rightBottom,
          child: message.type == types.MessageType.text
              ? Text(message.text)
              : child,
        );
      },
    );
