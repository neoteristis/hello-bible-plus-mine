import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart' as ui;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gpt/core/helper/unfocus_keyboard.dart';
import 'package:gpt/features/chat/presentation/widgets/chat/custom_bottom_widget.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/theme/chat_theme.dart';
import '../../../../core/widgets/bot_avatar.dart';
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
            // String defaultMessage = 'Bonjour. Comment puis-je vous aider?';
            // switch (state.conversation?.category?.id) {
            //   case 14:
            //     defaultMessage =
            //         'Bonjour. Pour savoir ce que la Bible dit sur un sujet.';
            //     break;
            //   case 15:
            //     defaultMessage =
            //         'Bonjour. Vous aimeriez savoir ce que dirait Jésus.';
            //     break;
            //   case 16:
            //     defaultMessage =
            //         'Bonjour. Vous aimeriez de l\'aide pour prier.';
            //     break;
            //   default:
            //     defaultMessage = 'Bonjour. Comment puis-je vous aider?';
            //     break;
            // }

            return ui.Chat(
              showUserAvatars: true,
              avatarBuilder: (uid) => const BotAvatar(),
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
              customBottomWidget: Visibility(
                visible: state.messages!.isNotEmpty,
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 15.0, bottom: 8.0, right: 15.0),
                  child: CustomBottomWidget(),
                  // child: TextField(
                  //   onChanged: (value) {
                  //     setState(() {});
                  //   },
                  //   controller:
                  //       textEditingController ?? TextEditingController(),
                  //   cursorColor: Theme.of(context).primaryColor,
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //     contentPadding: const EdgeInsets.only(left: 8),
                  //     suffixIcon: Visibility(
                  //       visible: textEditingController!.text.isNotEmpty,
                  //       child: IconButton(
                  //         onPressed: () {
                  //           unfocusKeyboard();
                  //           context.read<ChatBloc>().add(
                  //                 ChatMessageSent(
                  //                   textEditingController!.text,
                  //                 ),
                  //               );

                  //           textEditingController!.clear();
                  //         },
                  //         icon: Icon(
                  //           Icons.send_rounded,
                  //           color: Theme.of(context).primaryColor,
                  //         ),
                  //       ),
                  //     ),
                  //     hintText: 'Ecrivez-ici . . . ',
                  //     hintStyle: TextStyle(
                  //         color:
                  //             Theme.of(context).primaryColor.withOpacity(.7)),
                  //     border: const OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(10)),
                  //         borderSide: BorderSide.none),
                  //     focusedBorder: const OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(10)),
                  //         borderSide: BorderSide.none),
                  //   ),
                  // ),
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
