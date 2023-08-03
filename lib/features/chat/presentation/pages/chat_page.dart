import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/constants/status.dart';
import 'package:gpt/core/widgets/custom_progress_indicator.dart';
import 'package:gpt/features/container/pages/section/presentation/pages/section_page.dart';
import '../../../../core/helper/unfocus_keyboard.dart';
import '../../../container/pages/home/presentation/page/home_page.dart';
import '../bloc/chat_bloc/chat_bloc.dart';
import '../widgets/chat/chat_body_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';

class ChatPage extends StatefulWidget {
  static const String route = 'chat';

  const ChatPage({
    super.key,
    this.previousPage,
  });

  final String? previousPage;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listenWhen: (previous, current) =>
          previous.goBackHome != current.goBackHome,
      listener: (context, state) {
        if (state.goBackHome!) {
          unfocusKeyboard();
          context.go('/${HomePage.route}');
          context.read<ChatBloc>()
            ..add(
              ChatStreamCanceled(),
            )
            ..add(
              ChatConversationCleared(),
            );
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: context.read<ChatBloc>().scaffoldKey,
          resizeToAvoidBottomInset: true,
          appBar: CustomAppBar(
            previousPage: widget.previousPage ?? SectionPage.route,
          ),
          endDrawer: const CustomDrawer(),
          body: BlocBuilder<ChatBloc, ChatState>(
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
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        );
      },
    );
  }
}
