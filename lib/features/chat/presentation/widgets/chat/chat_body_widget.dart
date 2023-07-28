import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/features/chat/presentation/widgets/chat/custom_bottom_widget.dart';

import '../../bloc/chat_bloc/chat_bloc.dart';
import 'chat_list_widget.dart';

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
            Expanded(
              child: ChatListWidget(),
            ),
            CustomBottomWidget(),
          ],
        );
      },
    );
  }
}
