import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart' as ui;
import 'package:gpt/features/chat/presentation/widgets/chat/custom_bottom_widget.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/theme/chat_theme.dart';
// import '../../../../core/widgets/bot_avatar.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../bloc/chat_bloc.dart';
import 'chat/bubble_builder.dart';
import 'chat/empty_state_widget.dart';
import 'chat/list_bottom_chat_widget.dart';
import 'container_categories_widget.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({
    super.key,
  });

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  late TextEditingController? textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        switch (state.conversationStatus) {
          case Status.loading:
            return const Center(
              child: CustomProgressIndicator(),
            );
          case Status.loaded:
            return ui.Chat(
              // dateFormat: DateFormat('h:mm a'),
              // dateHeaderThreshold: 100,

              dateHeaderBuilder: (p0) => const SizedBox.shrink(),
              // showUserAvatars: true,
              // avatarBuilder: (uid) => const BotAvatar(),

              messages: state.messages ?? [],
              onSendPressed: (message) {
                context.read<ChatBloc>().add(ChatMessageSent(message.text));
              },
              bubbleBuilder: bubbleBuilder,
              emptyState: const EmptyStateWidget(),
              theme: chatTheme(context),
              user: state.sender!,
              listBottomWidget: const ListBottomChatWidget(),
              scrollPhysics: const BouncingScrollPhysics(),
              customBottomWidget: const Visibility(
                // visible: state.messages!.isNotEmpty,
                visible: true,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 15.0, bottom: 20.0, right: 15.0),
                  child: CustomBottomWidget(),
                ),
              ),
            );
          case Status.failed:
            return const ContainerCategoriesWidget();
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
