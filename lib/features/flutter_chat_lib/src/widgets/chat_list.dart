import 'package:diffutil_dart/diffutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:scrollview_observer/scrollview_observer.dart';

// import '../../../../core/helper/custom_scroll_physics.dart';
import '../models/bubble_rtl_alignment.dart';
import 'typing_indicator.dart';

/// Animated list that handles automatic animations and pagination.
class ChatList extends StatefulWidget {
  /// Creates a chat list widget.
  const ChatList({
    super.key,
    this.bottomWidget,
    required this.bubbleRtlAlignment,
    this.isLastPage,
    required this.itemBuilder,
    required this.items,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.onEndReached,
    this.onEndReachedThreshold,
    required this.scrollController,
    this.scrollPhysics,
    this.typingIndicatorOptions,
    required this.useTopSafeAreaInset,
    // this.chatObserver,
  });

  // final ChatScrollObserver? chatObserver;

  /// A custom widget at the bottom of the list.
  final Widget? bottomWidget;

  /// Used to set alignment of typing indicator.
  /// See [BubbleRtlAlignment].
  final BubbleRtlAlignment bubbleRtlAlignment;

  /// Used for pagination (infinite scroll) together with [onEndReached].
  /// When true, indicates that there are no more pages to load and
  /// pagination will not be triggered.
  final bool? isLastPage;

  /// Item builder.
  final Widget Function(Object, int? index) itemBuilder;

  /// Items to build.
  final List<Object> items;

  /// Used for pagination (infinite scroll). Called when user scrolls
  /// to the very end of the list (minus [onEndReachedThreshold]).
  final Future<void> Function()? onEndReached;

  /// A representation of how a [ScrollView] should dismiss the on-screen keyboard.
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// Used for pagination (infinite scroll) together with [onEndReached]. Can be anything from 0 to 1, where 0 is immediate load of the next page as soon as scroll starts, and 1 is load of the next page only if scrolled to the very end of the list. Default value is 0.75, e.g. start loading next page when scrolled through about 3/4 of the available content.
  final double? onEndReachedThreshold;

  /// Scroll controller for the main [CustomScrollView]. Also used to auto scroll
  /// to specific messages.
  final ScrollController scrollController;

  /// Determines the physics of the scroll view.
  final ScrollPhysics? scrollPhysics;

  /// Used to build typing indicator according to options.
  /// See [TypingIndicatorOptions].
  final TypingIndicatorOptions? typingIndicatorOptions;

  /// Whether to use top safe area inset for the list.
  final bool useTopSafeAreaInset;

  @override
  State<ChatList> createState() => _ChatListState();
}

/// [ChatList] widget state.
class _ChatListState extends State<ChatList>
    with SingleTickerProviderStateMixin {
  // late final Animation<double> _animation = CurvedAnimation(
  //   curve: Curves.easeOutQuad,
  //   parent: _controller,
  // );
  // late final AnimationController _controller = AnimationController(vsync: this);

  // bool _indicatorOnScrollStatus = false;
  // bool _isNextPageLoading = false;
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
  late List<Object> _oldData = List.from(widget.items);

  // late ScrollController _scrollController;
  ScrollPhysics? physics;
  // late ListObserverController observerController;
  // late ChatScrollObserver chatObserver;

  @override
  void initState() {
    super.initState();
    // _scrollController = ScrollController();

    // _scrollController.addListener(
    //   () {
    //     if (_scrollController.position.userScrollDirection ==
    //         ScrollDirection.forward) {
    //       physics = PositionRetainedScrollPhysics();
    //       setState(() {});
    //     } else {
    //       physics = null;
    //       setState(() {});
    //     }
    //   },
    // );
    // _scrollController = ScrollController();

    // /// Initialize ListObserverController
    // observerController =
    //     ListObserverController(controller: widget.scrollController)
    //       ..cacheJumpIndexOffset = false;

    // /// Initialize ChatScrollObserver
    // chatObserver = ChatScrollObserver(observerController)
    //   // Greater than this offset will be fixed to the current chat position.
    //   ..fixedPositionOffset = 9
    //   ..toRebuildScrollViewCallback = () {
    //     // Here you can use other way to rebuild the specified listView instead of [setState]
    //     setState(() {});
    //   }
    //   ..standby(
    //     mode: ChatScrollObserverHandleMode.generative,
    //     // changeCount: 1,
    //   );
    didUpdateWidget(widget);
  }

  void _calculateDiffs(List<Object> oldList) async {
    final diffResult = calculateListDiff<Object>(
      oldList,
      widget.items,
      equalityChecker: (item1, item2) {
        if (item1 is Map<String, Object> && item2 is Map<String, Object>) {
          final message1 = item1['message']! as types.Message;
          final message2 = item2['message']! as types.Message;

          return message1.id == message2.id;
        } else {
          return item1 == item2;
        }
      },
    );

    for (final update in diffResult.getUpdates(batch: false)) {
      update.when(
        insert: (pos, count) {
          _listKey.currentState?.insertItem(pos);
        },
        remove: (pos, count) {
          final item = oldList[pos];
          _listKey.currentState?.removeItem(
            pos,
            (_, animation) => _removedMessageBuilder(item, animation),
          );
        },
        change: (pos, payload) {},
        move: (from, to) {},
      );
    }

    // _scrollToBottomIfNeeded(oldList);

    _oldData = List.from(widget.items);
  }

  Widget _newMessageBuilder(int index, Animation<double> animation) {
    try {
      final item = _oldData[index];
      return widget.itemBuilder(item, index);

      // return SizeTransition(
      //   key: _valueKeyForItem(item),
      //   axisAlignment: -1,
      //   sizeFactor: animation.drive(CurveTween(curve: Curves.easeOutQuad)),
      //   child: widget.itemBuilder(item, index),
      // );
    } catch (e) {
      return const SizedBox();
    }
  }

  Widget _removedMessageBuilder(Object item, Animation<double> animation) =>
      SizeTransition(
        key: _valueKeyForItem(item),
        axisAlignment: -1,
        sizeFactor: animation.drive(CurveTween(curve: Curves.easeInQuad)),
        child: FadeTransition(
          opacity: animation.drive(CurveTween(curve: Curves.easeInQuad)),
          child: widget.itemBuilder(item, null),
        ),
      );

  // Hacky solution to reconsider.
  // void _scrollToBottomIfNeeded(List<Object> oldList) {
  //   try {
  //     // Take index 1 because there is always a spacer on index 0.
  //     final oldItem = oldList[1];
  //     final item = widget.items[1];

  //     if (oldItem is Map<String, Object> && item is Map<String, Object>) {
  //       final oldMessage = oldItem['message']! as types.Message;
  //       final message = item['message']! as types.Message;

  //       // Compare items to fire only on newly added messages.
  //       if (oldMessage.id != message.id) {
  //         // Run only for sent message.
  //         if (message.author.id == InheritedUser.of(context).user.id) {
  //           // Delay to give some time for Flutter to calculate new
  //           // size after new message was added.
  //           Future.delayed(const Duration(milliseconds: 100), () {
  //             if (widget.scrollController.hasClients) {
  //               widget.scrollController.animateTo(
  //                 0,
  //                 duration: const Duration(milliseconds: 200),
  //                 curve: Curves.easeInQuad,
  //               );
  //             }
  //           });
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     // Do nothing if there are no items.
  //   }
  // }

  Key? _valueKeyForItem(Object item) =>
      _mapMessage(item, (message) => ValueKey(message.id));

  T? _mapMessage<T>(Object maybeMessage, T Function(types.Message) f) {
    if (maybeMessage is Map<String, Object>) {
      return f(maybeMessage['message'] as types.Message);
    }
    return null;
  }

  // Widget _buildListView() {
  //   Widget resultWidget = CustomScrollView(
  //     controller: widget.scrollController,
  //     // shrinkWrap: chatObserver.isShrinkWrap,
  //     // keyboardDismissBehavior: widget.keyboardDismissBehavior,
  //     // scrollBehavior: MyCustomScrollBehavior(),
  //     // physics:
  //     //     ChatObserverClampingScrollPhysics(observer: widget.chatObserver!),
  //     // physics: widget.scrollPhysics,
  //     reverse: true,
  //     slivers: [
  //       if (widget.bottomWidget != null)
  //         SliverToBoxAdapter(child: widget.bottomWidget),
  //       SliverPadding(
  //         padding: const EdgeInsets.only(bottom: 4),
  //         sliver: SliverAnimatedList(
  //           findChildIndexCallback: (Key key) {
  //             if (key is ValueKey<Object>) {
  //               final newIndex = widget.items.indexWhere(
  //                 (v) => _valueKeyForItem(v) == key,
  //               );
  //               if (newIndex != -1) {
  //                 return newIndex;
  //               }
  //             }
  //             return null;
  //           },
  //           initialItemCount: widget.items.length,
  //           key: _listKey,
  //           itemBuilder: (_, index, animation) =>
  //               _newMessageBuilder(index, animation),
  //         ),
  //       ),
  //     ],
  //     // ),
  //   );

  //   resultWidget = ListViewObserver(
  //     controller: observerController,
  //     child: resultWidget,
  //   );
  //   return resultWidget;
  // }

  @override
  void didUpdateWidget(covariant ChatList oldWidget) {
    super.didUpdateWidget(oldWidget);

    _calculateDiffs(oldWidget.items);
  }

  @override
  void dispose() {
    // _controller.dispose();
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (_scrollController.hasClients) {
    //   final double old = _scrollController.position.pixels;
    //   // final double oldMax = _scrollController.position.maxScrollExtent;

    //   WidgetsBinding.instance.addPostFrameCallback(
    //     (_) {
    //       if (_scrollController.position.userScrollDirection ==
    //           ScrollDirection.reverse) {
    //         physics = PositionRetainedScrollPhysics();
    //         // final diff = _scrollController.position.maxScrollExtent - oldMax;
    //         // _scrollController.jumpTo(old + diff);
    //         setState(() {});
    //       } else {
    //         physics = null;
    //         setState(() {});
    //       }
    //     },
    //   );
    // }
    // return NotificationListener<ScrollNotification>(
    //   onNotification: (notification) {
    //     // if (notification.metrics.pixels > 10.0 && !_indicatorOnScrollStatus) {
    //     //   setState(() {
    //     //     _indicatorOnScrollStatus = !_indicatorOnScrollStatus;
    //     //   });
    //     // } else if (notification.metrics.pixels == 0.0 &&
    //     //     _indicatorOnScrollStatus) {
    //     //   setState(() {
    //     //     _indicatorOnScrollStatus = !_indicatorOnScrollStatus;
    //     //   });
    //     // }

    //     // if (widget.onEndReached == null || widget.isLastPage == true) {
    //     //   return false;
    //     // }

    //     // if (notification.metrics.pixels >=
    //     //     (notification.metrics.maxScrollExtent *
    //     //         (widget.onEndReachedThreshold ?? 0.75))) {
    //     //   if (widget.items.isEmpty || _isNextPageLoading) return false;

    //     //   _controller.duration = Duration.zero;
    //     //   _controller.forward();

    //     //   setState(() {
    //     //     _isNextPageLoading = true;
    //     //   });

    //     //   widget.onEndReached!().whenComplete(() {
    //     //     _controller.duration = const Duration(milliseconds: 300);
    //     //     _controller.reverse();

    //     //     setState(() {
    //     //       _isNextPageLoading = false;
    //     //     });
    //     //   });
    //     // }
    //     // if(widget)

    //     return false;
    //   },
    //   child:
    // return ListViewObserver(
    //   controller: observerController,
    //   child: _buildListView(),
    // );
    return CustomScrollView(
      controller: widget.scrollController,
      physics: widget.scrollPhysics,
      reverse: true,
      slivers: [
        if (widget.bottomWidget != null)
          SliverToBoxAdapter(child: widget.bottomWidget),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 4),
          sliver: SliverAnimatedList(
            findChildIndexCallback: (Key key) {
              if (key is ValueKey<Object>) {
                final newIndex = widget.items.indexWhere(
                  (v) => _valueKeyForItem(v) == key,
                );
                if (newIndex != -1) {
                  return newIndex;
                }
              }
              return null;
            },
            initialItemCount: widget.items.length,
            key: _listKey,
            itemBuilder: (_, index, animation) =>
                _newMessageBuilder(index, animation),
          ),
        ),
      ],
      // ),
    );
  }
}
