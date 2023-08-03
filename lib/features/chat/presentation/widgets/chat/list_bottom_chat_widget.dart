import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/constants/status.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';

import 'bottom_chat_loaded_widget.dart';
import 'bottom_chat_loading_widget.dart';

class ListBottomChatWidget extends StatelessWidget {
  const ListBottomChatWidget(this.lastIndex, {super.key});

  final int lastIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) =>
          previous.messageStatus != current.messageStatus,
      builder: (context, state) {
        switch (state.messageStatus) {
          case Status.loading:
            return BottomChatLoadingWidget(
              lastIndex: lastIndex,
            );
          case Status.loaded:
            return BottomChatLoadedWidget(
              lastIndex: lastIndex,
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
