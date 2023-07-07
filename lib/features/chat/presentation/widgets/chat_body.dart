import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gpt/core/helper/unfocus_keyboard.dart';

import '../../../../core/widgets/custom_bubble.dart';
import '../../../flutter_chat_lib/flutter_chat_ui.dart' as ui;
import 'package:gpt/features/chat/presentation/widgets/chat/custom_bottom_widget.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/helper/log.dart';
import '../../../../core/theme/chat_theme.dart';
// import '../../../../core/widgets/bot_avatar.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../bloc/chat_bloc.dart';
import 'chat/bubble_builder.dart';
import 'chat/empty_state_widget.dart';
import 'chat/list_bottom_chat_widget.dart';
import 'container_categories_widget.dart';

import 'package:scroll_to_index/scroll_to_index.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({
    super.key,
  });

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  late TextEditingController? textEditingController;
  // late AutoScrollController? _scrollController;

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
            // return Column(
            //   children: [
            //     Expanded(
            //       child: ListView.builder(
            //         // controller: _scrollController,
            //         physics: PositionRetainedScrollPhysics(shouldRetain: true),
            //         shrinkWrap: true,
            //         reverse: true,
            //         itemCount: state.messages?.length,
            //         itemBuilder: (context, index) {
            //           final message = state.messages?[index];
            //           if (index == 0) {
            //             return ListBottomChatWidget();
            //           }
            //           return CustomBubble(
            //             message: Text(
            //               (message as dynamic).text,
            //               // textScaleFactor: 1.2,
            //               style: TextStyle(
            //                 fontSize: 15,
            //                 // fontSize: 13,
            //                 height: 1.4,
            //                 fontWeight: FontWeight.w400,
            //               ),
            //             ),
            //           );
            //         },
            //         // children: [
            //         //   ListBottomChatWidget(),
            //         // ],
            //       ),
            //     ),
            //     CustomBottomWidget(),
            //   ],
            // );
            return ui.Chat(
              // scrollController: _scrollController,
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
                // child: Padding(
                //   padding:
                //       EdgeInsets.only(left: 15.0, bottom: 20.0, right: 15.0),
                child: CustomBottomWidget(),
                // ),
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

extension BottomReachExtension on AutoScrollController {
  void onBottomReach(VoidCallback callback,
      {double sensitivity = 200.0, Duration? throttleDuration}) {
    final duration = throttleDuration ?? Duration(milliseconds: 200);
    Timer? timer;

    addListener(() {
      if (timer != null) {
        return;
      }

      // I used the timer to destroy the timer
      timer = Timer(duration, () => timer = null);

      // see Esteban Díaz answer
      final maxScroll = position.maxScrollExtent;
      final currentScroll = position.pixels;
      if (maxScroll - currentScroll <= sensitivity) {
        callback();
      }
    });
  }
}

class PositionRetainedScrollPhysics extends ScrollPhysics {
  final bool shouldRetain;
  const PositionRetainedScrollPhysics({super.parent, this.shouldRetain = true});

  @override
  PositionRetainedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return PositionRetainedScrollPhysics(
      parent: buildParent(ancestor),
      shouldRetain: shouldRetain,
    );
  }

  @override
  double adjustPositionForNewDimensions({
    required ScrollMetrics oldPosition,
    required ScrollMetrics newPosition,
    required bool isScrolling,
    required double velocity,
  }) {
    final position = super.adjustPositionForNewDimensions(
      oldPosition: oldPosition,
      newPosition: newPosition,
      isScrolling: isScrolling,
      velocity: velocity,
    );

    final diff = newPosition.maxScrollExtent - oldPosition.maxScrollExtent;

    if (oldPosition.pixels > oldPosition.minScrollExtent &&
        diff > 0 &&
        shouldRetain) {
      return position + diff;
    } else {
      return position;
    }
  }
}

// class PositionRetainedScrollPhysics extends ScrollPhysics {
//   final bool shouldRetain;
//   const PositionRetainedScrollPhysics({super.parent, this.shouldRetain = true});

//   @override
//   PositionRetainedScrollPhysics applyTo(ScrollPhysics? ancestor) {
//     return PositionRetainedScrollPhysics(
//       parent: buildParent(ancestor),
//       shouldRetain: shouldRetain,
//     );
//   }

//   @override
//   double adjustPositionForNewDimensions({
//     required ScrollMetrics oldPosition,
//     required ScrollMetrics newPosition,
//     required bool isScrolling,
//     required double velocity,
//   }) {
//     final position = super.adjustPositionForNewDimensions(
//       oldPosition: oldPosition,
//       newPosition: newPosition,
//       isScrolling: isScrolling,
//       velocity: velocity,
//     );

//     final diff = newPosition.maxScrollExtent - oldPosition.maxScrollExtent;

//     if (oldPosition.pixels > oldPosition.minScrollExtent &&
//         diff > 0 &&
//         shouldRetain) {
//       return position + diff;
//     } else {
//       return position;
//     }
//   }
// }
