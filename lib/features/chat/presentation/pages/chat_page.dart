import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<types.Message> _messages = [];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hello Bible'),
        ),
        drawer: Drawer(
          child: Column(children: []),
        ),
        body: Chat(
          messages: _messages,
          onAttachmentPressed: () {},
          onMessageTap: (context, message) {},
          onPreviewDataFetched: (_, __) {},
          onSendPressed: (message) {
            print(message.text);
          },
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
          user: const types.User(
            firstName: 'loggedInUser 1',
            lastName: 'best',
            id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
          ),
        ),
      ),
    );
  }
}
