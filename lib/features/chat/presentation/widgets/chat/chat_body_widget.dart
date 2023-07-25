import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gpt/core/widgets/custom_bubble.dart';
import 'package:gpt/features/chat/domain/entities/text_message.dart';
import 'package:gpt/features/chat/presentation/widgets/chat/bottom_chat_loading_widget.dart';
import 'package:gpt/features/chat/presentation/widgets/chat/custom_bottom_widget.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/widgets/custom_progress_indicator.dart';
import '../../../domain/entities/message_by_role.dart';
import '../../bloc/chat_bloc/chat_bloc.dart';
import 'chat_list_widget.dart';
import 'suggestion_item.dart';
import '../container_categories_widget.dart';

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
        return Stack(
          key: state.chatKey,
          children: const [
            ChatListWidget(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomWidget(),
            ),
          ],
        );
      },
    );
  }
}


