import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart' as ui;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gpt/core/constants/color_constants.dart';
import 'package:gpt/features/chat/presentation/widgets/categories_widget.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/theme/chat_theme.dart';
import '../../../../core/widgets/bot_avatar.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../bloc/chat_bloc.dart';
import 'chat/bubble_builder.dart';
import 'chat/list_bottom_chat_widget.dart';
import 'container_categories_widget.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const brown = ColorConstants.primary;
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        switch (state.conversationStatus) {
          case Status.loading:
            return const Center(
              child: CustomProgressIndicator(),
            );
          case Status.loaded:
            String defaultMessage = 'Bonjour. Comment puis-je vous aider?';
            switch (state.conversation?.category?.id) {
              case 14:
                defaultMessage =
                    'Bonjour. Pour savoir ce que la Bible dit sur un sujet.';
                break;
              case 15:
                defaultMessage =
                    'Bonjour. Vous aimeriez savoir ce que dirait Jésus.';
                break;
              case 16:
                defaultMessage =
                    'Bonjour. Vous aimeriez de l\'aide pour prier.';
                break;
              default:
                defaultMessage = 'Bonjour. Comment puis-je vous aider?';
                break;
            }

            return ui.Chat(
              showUserAvatars: true,
              avatarBuilder: (uid) => const BotAvatar(),
              messages: state.messages ?? [],
              onSendPressed: (message) {
                context.read<ChatBloc>().add(ChatMessageSent(message));
              },
              // bubbleRtlAlignment: ui.BubbleRtlAlignment.right,
              bubbleBuilder: bubbleBuilder,
              emptyState: Center(
                child: Text(
                  defaultMessage,
                  style: TextStyle(
                    color: brown,
                  ),
                ),
              ),
              // disableImageGallery: true,
              theme: chatTheme(context),
              user: state.sender!,
              listBottomWidget: const ListBottomChatWidget(),
              scrollPhysics: const BouncingScrollPhysics(),
            );
          case Status.failed:
            return ContainerCategoriesWidget();
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
