import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_bubble.dart';
import '../../bloc/chat_bloc/chat_bloc.dart';
import 'empty_chat_widget.dart';
import 'list_bottom_chat_widget.dart';

class ChatListWidget extends StatefulWidget {
  const ChatListWidget({super.key});

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state.isLoading!) {
          if (state.scrollController!.hasClients) {
            final box = state.containerKey?.currentContext?.findRenderObject()
                as RenderBox?;
            final boxField = state.textFieldKey?.currentContext
                ?.findRenderObject() as RenderBox?;
            final boxChat =
                state.chatKey?.currentContext?.findRenderObject() as RenderBox?;

            double? containerHeight = 0.0;
            double? fieldHeight = 0.0;
            double? chatHeight = 0.0;
            if (box != null && box.hasSize) {
              containerHeight = box.size.height;
              if (boxField != null && boxField.hasSize) {
                fieldHeight = boxField.size.height;
              }
              if (boxChat != null && boxChat.hasSize) {
                chatHeight = boxChat.size.height;
              }
              final chatViewArea = chatHeight - fieldHeight;
              if (!state.isUserTap!) {
                // uncomment from here

                if (containerHeight < chatViewArea) {
                  state.scrollController!
                      .jumpTo(state.scrollController!.position.maxScrollExtent);
                }
              }
            }
          }
        }
      },
      builder: (context, state) {
        return BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return NotificationListener(
              onNotification: (ScrollNotification scrollNotif) {
                if (scrollNotif is UserScrollNotification) {
                  context.read<ChatBloc>().add(const ChatUserTapChanged(true));
                }
                return false;
              },
              child: ListView.builder(
                key: state.listKey,
                controller: state.scrollController,
                itemBuilder: (ctx, index) {
                  if (state.messages == null || state.messages!.isEmpty) {
                    return const EmptyChatWidget();
                  }

                  if (index == 0 && state.messages!.length > 1) {
                    // the first item on the list
                    return Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: customBubbleBuilder(
                            message: state.messages![index],
                            context: context,
                          ),
                        ),
                      ],
                    );
                  }
                  if (index == state.messages!.length - 1 ||
                      state.messages!.length == 1) {
                    if (!state.readOnly!) {
                      return ListBottomChatWidget(index);
                    }
                    return customBubbleBuilder(
                      message: state.messages![index],
                      context: context,
                    );
                  } else {
                    return customBubbleBuilder(
                      message: state.messages![index],
                      context: context,
                    );
                  }
                },
                itemCount: state.messages == null || state.messages!.isEmpty
                    ? 1
                    : state.messages?.length,
              ),
            );
          },
        );
      },
    );
  }
}
