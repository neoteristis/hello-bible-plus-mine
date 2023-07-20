import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gpt/core/widgets/custom_bubble.dart';
import 'package:gpt/features/chat/presentation/widgets/chat/custom_bottom_widget.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/typing_indicator.dart';
import '../bloc/chat_bloc.dart';
import 'chat/suggestion_item.dart';
import 'container_categories_widget.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) =>
          previous.conversationStatus != current.conversationStatus,
      builder: (context, state) {
        switch (state.conversationStatus) {
          case Status.loading:
            return const Center(
              child: CustomProgressIndicator(),
            );
          case Status.loaded:
            return const CustomChat();
          case Status.failed:
            return const ContainerCategoriesWidget();
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class CustomChat extends StatelessWidget {
  const CustomChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) => previous.chatKey != current.chatKey,
      builder: (context, state) {
        return Column(
          key: state.chatKey,
          children: const [
            Expanded(child: ChatList()),
            CustomBottomWidget(),
          ],
        );
      },
    );
  }
}

class ChatList extends StatelessWidget {
  const ChatList({
    super.key,
  });

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
            final listBox =
                state.listKey?.currentContext?.findRenderObject() as RenderBox?;

            double? containerHeight = 0.0;
            double? fieldHeight = 0.0;
            double? chatHeight = 0.0;
            double? listHeight = 0.0;
            if (box != null && box.hasSize) {
              containerHeight = box.size.height;
              if (boxField != null && boxField.hasSize) {
                fieldHeight = boxField.size.height;
              }
              if (boxChat != null && boxChat.hasSize) {
                chatHeight = boxChat.size.height;
              }
              if (listBox != null && listBox.hasSize) {
                listHeight = listBox.size.height;
              }
              final chatViewArea = chatHeight - fieldHeight;
              // print(state.scrollController?.hasClients);
              // print(isBottom(
              //   scrollController: state.scrollController!,
              //   offset: 0.95,
              // ));
              // print('position ${state.scrollController?.position.pixels}');
              // print(
              //     'max scroll extent ${state.scrollController!.position.maxScrollExtent}');

              // if (isBottom(
              //   scrollController: state.scrollController!,
              //   offset: 0.95,
              // )) {
              // state.scrollController?.;
              print(state.isUserTap);
              if (!state.isUserTap!) {
                if (containerHeight < chatViewArea) {
                  // print('-------jump');
                  state.scrollController!
                      .jumpTo(state.scrollController!.position.maxScrollExtent);
                }
              }

              // if (state.isUserTap!) {
              //   return;
              // } else if (!state.isUserTap! &&
              //     !isBottom(scrollController: state.scrollController!)) {
              //   // print('--------isn bottom');
              //   return;
              // } else {
              //   if (containerHeight < chatViewArea) {
              //     // print('-------jump');
              //     state.scrollController!
              //         .jumpTo(state.scrollController!.position.maxScrollExtent);
              //   }
              // }

              // if (listHeight >= chatViewArea &&
              //     !state.isUserTap! &&
              //     containerHeight < chatViewArea) {
              //   state.scrollController!
              //       .jumpTo(state.scrollController!.position.maxScrollExtent);
              // }
              // }
              // else {
              //   state.scrollController!
              //       .jumpTo(state.scrollController!.position.maxScrollExtent);
              // }
            }
          }
        }
      },
      builder: (context, state) {
        return BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return NotificationListener(
              onNotification: (ScrollNotification scrollNotif) {
                // if(state)

                if (scrollNotif is UserScrollNotification) {
                  context.read<ChatBloc>().add(const ChatUserTapChanged(true));
                }
                // else if (scrollNotif is ScrollEndNotification) {
                //   context.read<ChatBloc>().add(const ChatUserTapChanged(false));
                // }
                return false;
              },
              child: ListView.builder(
                key: state.listKey,
                controller: state.scrollController,
                itemBuilder: (ctx, index) {
                  if (state.messages == null || state.messages!.isEmpty) {
                    return EmptyChatWidget();
                  }

                  if (index == state.messages!.length - 1) {
                    if (!state.readOnly!) {
                      return ListBottomChat(index);
                    }
                    return customBubbleBuilder(
                      message: state.messages![index],
                    );
                  }
                  //  else if (index == 0) {
                  //   return Column(
                  //     children: [
                  //       const SizedBox(
                  //         height: 8,
                  //       ),
                  //       Align(
                  //         alignment: Alignment.topLeft,
                  //         child: customBubbleBuilder(
                  //           message: state.messages![index],
                  //         ),
                  //       ),
                  //     ],
                  //   );
                  // }
                  else {
                    return customBubbleBuilder(
                      message: state.messages![index],
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
                  color: Theme.of(context).colorScheme.onPrimary,
                  nip: BubbleNip.leftBottom,
                  message: Text(
                    state.incoming ?? '',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 17.sp,
                      // fontSize: 15,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        BlocBuilder<ChatBloc, ChatState>(
          buildWhen: (previous, current) =>
              previous.messageStatus != current.messageStatus,
          builder: (context, state) {
            switch (state.messageStatus) {
              case Status.loaded:
                return BlocBuilder<ChatBloc, ChatState>(
                  buildWhen: (previous, current) =>
                      previous.suggestions != current.suggestions ||
                      previous.isLoading != current.isLoading ||
                      previous.maintainScroll != current.maintainScroll,
                  builder: (context, state) {
                    final suggestions = state.suggestions;
                    if (suggestions == null ||
                        suggestions.isEmpty ||
                        state.isLoading! ||
                        state.maintainScroll!) {
                      return const SizedBox.shrink();
                    }
                    return Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                        bottom: 15,
                      ),
                      margin: const EdgeInsets.only(top: 15.0),
                      // width: double.infinity,
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
                );
              default:
                return const SizedBox.shrink();
            }
          },
        )
      ],
    );
  }
}

class ListBottomChat extends StatelessWidget {
  const ListBottomChat(this.lastIndex, {super.key});

  final int lastIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) =>
          previous.messageStatus != current.messageStatus,
      builder: (context, state) {
        switch (state.messageStatus) {
          case Status.loading:
            return BottomChatLoading(lastIndex: lastIndex);
          case Status.loaded:
            return BottomChatLoaded(lastIndex: lastIndex);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class BottomChatLoaded extends StatelessWidget {
  const BottomChatLoaded({
    super.key,
    required this.lastIndex,
  });

  final int lastIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
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
                  );
                },
              ),
            ),
            BlocBuilder<ChatBloc, ChatState>(
              buildWhen: (previous, current) =>
                  previous.incoming != current.incoming ||
                  previous.containerKey != current.containerKey,
              builder: (context, state) {
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: CustomBubble(
                    key: state.containerKey,
                    color: Theme.of(context).colorScheme.onPrimary,
                    nip: BubbleNip.leftBottom,
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
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                        bottom: 15,
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

class BottomChatLoading extends StatelessWidget {
  const BottomChatLoading({
    super.key,
    required this.lastIndex,
  });

  final int lastIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ChatBloc, ChatState>(
          buildWhen: (previous, current) =>
              previous.messages != current.messages,
          builder: (context, state) {
            return Align(
              alignment: Alignment.topRight,
              child: customBubbleBuilder(
                message: state.messages![lastIndex],
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: CustomBubble(
            color: Theme.of(context).colorScheme.onPrimary,
            padding: EdgeInsets.zero,
            nip: BubbleNip.leftBottom,
            message: const TypingIndicatorWidget(),
          ),
        ),
      ],
    );
  }
}
