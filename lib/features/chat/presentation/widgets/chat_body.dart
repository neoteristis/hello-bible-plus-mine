import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/helper/custom_scroll_physics.dart';
// import 'package:scrollview_observer/scrollview_observer.dart';
import '../../../../core/helper/log.dart';
import '../../../flutter_chat_lib/flutter_chat_ui.dart' as ui;
import 'package:gpt/features/chat/presentation/widgets/chat/custom_bottom_widget.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/theme/chat_theme.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../bloc/chat_bloc.dart';
import 'chat/bubble_builder.dart';
import 'chat/empty_state_widget.dart';
import 'chat/list_bottom_chat_widget.dart';
import 'container_categories_widget.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listenWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.suggestionLoaded != current.suggestionLoaded ||
          previous.maintainScroll != current.maintainScroll
      // ||
      // previous.incoming != current.incoming ||
      // previous.newMessage != current.newMessage
      ,
      listener: (context, state) {
        if (!state.isLoading! &&
            state.suggestionLoaded! &&
            !state.maintainScroll!) {
          Log.info('good');
          context.read<ChatBloc>().add(
                const ChatScrollPhysicsSwitched(
                  AlwaysScrollableScrollPhysics(),
                  addTimer: true,
                ),
              );
        }
      },
      builder: (context, state) {
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
                return const ChatLoaded();
              case Status.failed:
                return const ContainerCategoriesWidget();
              default:
                return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}

class ChatLoaded extends StatefulWidget {
  const ChatLoaded({
    super.key,
  });

  @override
  State<ChatLoaded> createState() => _ChatLoadedState();
}

class _ChatLoadedState extends State<ChatLoaded> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification &&
                state.isLoading!) {
              context.read<ChatBloc>().add(
                    const ChatMaintainScrollChanged(true),
                  );
            } else if (scrollNotification is ScrollEndNotification) {
              context.read<ChatBloc>().add(
                    const ChatMaintainScrollChanged(false),
                  );
            }
            // else if (scrollNotification is ScrollUpdateNotification &&
            //     state.isLoading!) {
            //   print(2);
            //   print(3);
            //   if (scrollNotification.metrics.atEdge) {
            //     print(4);
            //     context.read<ChatBloc>().add(
            //           const ChatMaintainScrollChanged(false),
            //         );
            //   } else {
            //     context.read<ChatBloc>().add(
            //           const ChatMaintainScrollChanged(true),
            //         );
            //   }
            // }
            return false;
          },
          child: const CustomChat(),
        );
      },
    );
  }
}

class CustomChat extends StatefulWidget {
  const CustomChat({
    super.key,
  });

  @override
  State<CustomChat> createState() => _CustomChatState();
}

class _CustomChatState extends State<CustomChat> {
  // late ScrollController _scrollController;
  // late ListObserverController observerController;
  // late ChatScrollObserver chatObserver;

  @override
  void initState() {
    super.initState();
    // _scrollController = ScrollController();

    // /// Initialize ListObserverController
    // observerController = ListObserverController(controller: _scrollController)
    //   ..cacheJumpIndexOffset = true;

    // /// Initialize ChatScrollObserver
    // chatObserver = ChatScrollObserver(observerController)
    //   // Greater than this offset will be fixed to the current chat position.
    //   ..fixedPositionOffset = 5
    //   ..toRebuildScrollViewCallback = () {
    //     // Here you can use other way to rebuild the specified listView instead of [setState]
    //     setState(() {});
    //   }
    //   ..standby(
    //     mode: ChatScrollObserverHandleMode.generative,
    //     // changeCount: 1,
    //   );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) =>
          previous.messages != current.messages ||
          previous.scrollPhysics != current.scrollPhysics,
      builder: (context, state) {
        Log.info(state.scrollPhysics);
        Log.info(state.maintainScroll);
        return ui.Chat(
          scrollPhysics: state.scrollPhysics,
          // chatObserver: chatObserver,
          // scrollController: _scrollController,
          dateHeaderBuilder: (p0) => const SizedBox.shrink(),
          messages: state.messages ?? [],
          onSendPressed: (message) {
            // chatObserver.standby();
            context.read<ChatBloc>().add(ChatMessageSent(message.text));
          },
          bubbleBuilder: bubbleBuilder,
          emptyState: const EmptyStateWidget(),
          theme: chatTheme(context),
          user: state.sender!,
          listBottomWidget: const ListBottomChatWidget(),
          customBottomWidget: const CustomBottomWidget(),
        );
      },
    );
  }
}

// extension BottomReachExtension on AutoScrollController {
//   void onBottomReach(VoidCallback callback,
//       {double sensitivity = 200.0, Duration? throttleDuration}) {
//     final duration = throttleDuration ?? const Duration(milliseconds: 200);
//     Timer? timer;

//     addListener(() {
//       if (timer != null) {
//         return;
//       }

//       // I used the timer to destroy the timer
//       timer = Timer(duration, () => timer = null);

//       // see Esteban Díaz answer
//       final maxScroll = position.maxScrollExtent;
//       final currentScroll = position.pixels;
//       if (maxScroll - currentScroll <= sensitivity) {
//         callback();
//       }
//     });
//   }
// }