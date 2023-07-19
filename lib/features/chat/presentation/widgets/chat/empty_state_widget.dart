import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/helper/custom_scroll_physics.dart';
import '../../../../../core/helper/unfocus_keyboard.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../core/widgets/custom_bubble.dart';
import '../../bloc/chat_bloc.dart';
import '../typing_indicator.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        switch (state.messageStatus) {
          case Status.loading:
            return const Padding(
              padding: EdgeInsets.only(left: 15.0, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const BotAvatar(),
                  Expanded(
                    child: TypingIndicator(
                      showIndicator: true,
                      flashingCircleDarkColor: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          case Status.loaded:
            return ListView(
              reverse: true,
              physics: const PositionRetainedScrollPhysics(),
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<ChatBloc, ChatState>(
                  buildWhen: (previous, current) =>
                      previous.messageStatus != current.messageStatus,
                  builder: (context, state) {
                    switch (state.messageStatus) {
                      case Status.loaded:
                        return BlocBuilder<ChatBloc, ChatState>(
                          buildWhen: (previous, current) =>
                              previous.suggestions != current.suggestions ||
                              previous.isLoading != current.isLoading,
                          builder: (context, state) {
                            final suggestions = state.suggestions;
                            if (suggestions == null ||
                                suggestions.isEmpty ||
                                state.isLoading!) {
                              return const SizedBox.shrink();
                            }
                            return FadeIn(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 25,
                                  right: 25,
                                  top: 20,
                                  bottom: 15,
                                ),
                                margin: const EdgeInsets.only(top: 15.0),
                                // width: double.infinity,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  border: Border(
                                    top: BorderSide(
                                      color: Theme.of(context).dividerColor,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    ...suggestions.map(
                                      (e) => SuggestionItem(e),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * .90),
                        child: CustomBubble(
                          color: Theme.of(context).colorScheme.onPrimary,
                          nip: BubbleNip.leftBottom,
                          message: Text(
                            state.incoming ?? '',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 15.sp,
                              // fontSize: 15,
                              height: 1.4,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // BlocBuilder<ChatBloc, ChatState>(
                //   buildWhen: (previous, current) =>
                //       previous.suggestions != current.suggestions ||
                //       previous.focusNode != current.focusNode,
                //   builder: (context, state) {
                //     final suggestions = state.suggestions;
                //     if (suggestions == null ||
                //         suggestions.isEmpty ||
                //         !state.focusNode!.hasFocus) {
                //       return const SizedBox.shrink();
                //     }
                //     return Column(
                //       children: [
                //         const SizedBox(
                //           height: 15,
                //         ),
                //         SingleChildScrollView(
                //           scrollDirection: Axis.horizontal,
                //           child: Row(
                //             children: [
                //               const SizedBox(
                //                 width: 24,
                //               ),
                //               ...suggestions.map(
                //                 (e) => SuggestionItem(e),
                //               ),
                //               // SuggestionItem('this is a suggestion'),
                //               // SuggestionItem('This is another question long'),
                //               // SuggestionItem(
                //               //     'This is third and last question long'),
                //             ],
                //           ),
                //         ),
                //         const SizedBox(
                //           height: 15,
                //         ),
                //       ],
                //     );
                //   },
                // ),
              ],
            );
          case Status.failed:
            return Center(
              child: Text(
                state.failure?.message ?? 'Une erreur s\'est produite',
                style: const TextStyle(color: Colors.red),
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class SuggestionItem extends StatelessWidget {
  const SuggestionItem(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    // final receiverContainer = Theme.of(context).colorScheme.onPrimary;
    final light = isLight(context);
    final color = Theme.of(context).colorScheme.tertiary;
    return GestureDetector(
      onTap: () {
        unfocusKeyboard();
        context.read<ChatBloc>().add(
              ChatMessageSent(
                text,
              ),
            );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: const Color(0xFF000000)
          //         .withOpacity(0.1), // shadow color with opacity
          //     spreadRadius: 0, // spread radius
          //     blurRadius: 10, // blur radius
          //     offset: const Offset(0, 4), // offset in x and y direction
          //   ),
          // ],
          border: !light
              ? Border.all(color: Theme.of(context).dividerColor, width: 1)
              : Border.all(color: const Color(0xFFF5F5F5), width: 1),
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(
          bottom: 10,
          // left: 8,
          right: 8,
        ),
        child: Text(
          text,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 14.sp,
            // fontSize: 14,
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../bloc/chat_bloc.dart';

// class EmptyStateWidget extends StatefulWidget {
//   const EmptyStateWidget({super.key});

//   @override
//   State<EmptyStateWidget> createState() => _EmptyStateWidgetState();
// }

// class _EmptyStateWidgetState extends State<EmptyStateWidget> {
//   late TextEditingController? textEditingController;

//   @override
//   void initState() {
//     super.initState();
//     textEditingController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ChatBloc, ChatState>(
//       buildWhen: (previous, current) =>
//           previous.conversation != current.conversation,
//       builder: (context, state) {
//         String? welcomePhrase;
//         try {
//           welcomePhrase = state.categories
//               ?.firstWhere(
//                   (element) => element.id == state.conversation?.category?.id)
//               .welcomePhrase;
//         } catch (_) {
//           welcomePhrase = 'Bonjour. Comment puis-je vous aider ?';
//         }
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             // Spacer(
//             //   flex: 6,
//             // ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0),
//               child: ListTile(
//                 minVerticalPadding: 40,
//                 // visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
//                 contentPadding: EdgeInsets.zero,
//                 // leading: const Logo(
//                 //   size: Size(22, 22),
//                 // ),
//                 title: Text(
//                   state.conversation!.category?.name ?? '',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//                 subtitle: Text(
//                   state.conversation!.category?.welcomePhrase ?? '',
//                   softWrap: false,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14,
//                     color: Theme.of(context).colorScheme.tertiary,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
