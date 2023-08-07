import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../../core/widgets/custom_bubble.dart';
import '../../bloc/chat_bloc/chat_bloc.dart';
import 'empty_chat_widget.dart';
import 'list_bottom_chat_widget.dart';

class ChatListWidget extends StatelessWidget {
  const ChatListWidget({super.key});

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

            double containerHeight = 0.0;
            double fieldHeight = 0.0;
            double chatHeight = 0.0;
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
            final messages = state.messages;
            return NotificationListener(
              onNotification: (ScrollNotification scrollNotif) {
                if (scrollNotif is UserScrollNotification) {
                  context.read<ChatBloc>().add(const ChatUserTapChanged(true));
                }
                return false;
              },
              child: KeyboardVisibilityBuilder(builder: (context, isVisible) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    ListView.builder(
                      key: state.listKey,
                      controller: state.scrollController,
                      itemCount: messages == null || messages.isEmpty
                          ? 1
                          : messages.length,
                      itemBuilder: (ctx, index) {
                        if (messages == null || messages.isEmpty) {
                          return const EmptyChatWidget();
                        }
                        if (index == 0 && messages.length > 1) {
                          // the first item on the list
                          return Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: CustomBubbleBuilder(
                                  message: messages[index],
                                  context: context,
                                  index: index,
                                ),
                              ),
                            ],
                          );
                        }
                        if (index == messages.length - 1 ||
                            messages.length == 1) {
                          // if (!state.readOnly!) {
                          return ListBottomChatWidget(index);
                          // }
                          // return CustomBubbleBuilder(
                          //   message: messages[index],
                          //   context: context,
                          //   index: index,
                          // );
                        } else {
                          return CustomBubbleBuilder(
                            message: messages[index],
                            context: context,
                            index: index,
                          );
                        }
                      },
                    ),
                    if (state.scrollController!.hasClients &&
                        !isVisible &&
                        state.scrollController!.position.pixels <
                            state.scrollController!.position.maxScrollExtent)
                      Positioned(
                        bottom: 0,
                        child: FloatingActionButton.small(
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          elevation: 1,
                          onPressed: () {
                            state.scrollController?.animateTo(
                              state.scrollController?.position
                                      .maxScrollExtent ??
                                  0,
                              duration: const Duration(
                                microseconds: 300,
                              ),
                              curve: Curves.ease,
                            );
                          },
                          child: const Icon(
                            Icons.expand_circle_down_outlined,
                          ),
                        ),
                      )
                  ],
                );
              }),
            );
          },
        );
      },
    );
  }
}
