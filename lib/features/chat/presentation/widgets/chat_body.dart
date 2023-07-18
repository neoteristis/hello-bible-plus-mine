import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gpt/core/widgets/custom_bubble.dart';
import 'package:gpt/features/chat/presentation/widgets/chat/custom_bottom_widget.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/typing_indicator.dart';
import '../bloc/chat_bloc.dart';
import 'chat/list_bottom_chat_widget.dart';
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
    return const Column(
      children: [
        Chat(),
        CustomBottomWidget(),
      ],
    );
  }
}

class Chat extends StatelessWidget {
  const Chat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Expanded(
          child: state.messages != null && state.messages!.isNotEmpty
              ? const ChatList()
              : const EmptyChatWidget(),
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
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return ListView.builder(
          controller: state.scrollController,
          itemBuilder: (ctx, index) {
            if (index == state.messages!.length - 1) {
              if (!state.readOnly!) {
                return ListBottomChat(index);
              }
              return customBubbleBuilder(
                message: state.messages![index],
              );
            } else if (index == 0) {
              return Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customBubbleBuilder(
                      message: state.messages![index],
                    ),
                  ),
                ],
              );
            } else {
              return customBubbleBuilder(
                message: state.messages![index],
              );
            }
          },
          itemCount: state.messages?.length,
        );
      },
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
              alignment: Alignment.topRight,
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
                  previous.incoming != current.incoming,
              builder: (context, state) {
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: CustomBubble(
                    color: Theme.of(context).colorScheme.onPrimary,
                    nip: BubbleNip.leftBottom,
                    message: Text(
                      state.incoming ?? '',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 17.sp,
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

class EmptyChatWidget extends StatelessWidget {
  const EmptyChatWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                        fontSize: 15.sp,
                        // fontSize: 13,
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
      ),
    );
  }
}
