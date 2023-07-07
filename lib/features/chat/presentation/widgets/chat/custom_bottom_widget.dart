import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gpt/features/flutter_chat_lib/src/models/bubble_rtl_alignment.dart';
import '../../../../../core/constants/status.dart';
import '../../../../../core/helper/unfocus_keyboard.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../flutter_chat_lib/src/widgets/typing_indicator.dart';
import '../../bloc/chat_bloc.dart';
import 'empty_state_widget.dart';

class CustomBottomWidget extends StatefulWidget {
  const CustomBottomWidget({super.key});

  @override
  State<CustomBottomWidget> createState() => _CustomBottomWidgetState();
}

class _CustomBottomWidgetState extends State<CustomBottomWidget> {
  late TextEditingController? textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  // @override
  // void dispose() {
  //   print('--------------------dispose it--------------');
  //   context.read<ChatBloc>().add(ChatFocusNodeDisposed());
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final hintColor = Theme.of(context)
        .colorScheme
        .onBackground
        .withOpacity(isLight(context) ? 1 : .7);
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) =>
          previous.focusNode != current.focusNode ||
          previous.isLoading != current.isLoading,
      // selector: (state) {
      //   return state.focusNode!;
      // },
      builder: (context, state) {
        return Container(
          // color: Colors.white,
          padding:
              const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 25),
          // margin: const EdgeInsets.only(top: 8.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: Column(
            children: [
              // BlocBuilder<ChatBloc, ChatState>(
              //   buildWhen: (previous, current) =>
              //       previous.messageStatus != current.messageStatus,
              //   builder: (context, state) {
              //     switch (state.messageStatus) {
              //       case Status.loaded:
              //         return BlocBuilder<ChatBloc, ChatState>(
              //           buildWhen: (previous, current) =>
              //               previous.suggestions != current.suggestions ||
              //               previous.focusNode != current.focusNode,
              //           builder: (context, state) {
              //             final suggestions = state.suggestions;
              //             if (suggestions == null ||
              //                 suggestions.isEmpty ||
              //                 !state.focusNode!.hasFocus) {
              //               return const SizedBox.shrink();
              //             }
              //             return Column(
              //               children: [
              //                 ...suggestions.map(
              //                   (e) => SuggestionItem(e),
              //                 ),
              //               ],
              //             );
              //           },
              //         );
              //       default:
              //         return const SizedBox.shrink();
              //     }
              //   },
              // ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      focusNode: state.focusNode,
                      controller:
                          textEditingController ?? TextEditingController(),
                      cursorColor: Theme.of(context).primaryColor,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                      onSubmitted: (_) {
                        if (textEditingController != null) {
                          if (textEditingController!.text.isEmpty) {
                            return;
                          }
                          unfocusKeyboard();
                          context.read<ChatBloc>().add(
                                ChatMessageSent(
                                  textEditingController!.text,
                                ),
                              );

                          textEditingController!.clear();
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onPrimary,
                        // contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        // hintText: AppLocalizations.of(context)!.writeYourMessage,
                        hintText: state.conversation?.category?.placeholder,
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          // fontSize: 14,
                          color: hintColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24)),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.w),
                          // color: Theme.of(context).primaryColor,
                          // width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24)),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.w),

                          // color: Theme.of(context).primaryColor,
                          // width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  if (!state.isLoading!)
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: IconButton(
                        onPressed: () {
                          if (textEditingController != null) {
                            if (textEditingController!.text.isEmpty) {
                              return;
                            }
                            unfocusKeyboard();
                            context.read<ChatBloc>().add(
                                  ChatMessageSent(
                                    textEditingController!.text,
                                  ),
                                );

                            textEditingController!.clear();
                          }
                        },
                        icon: BlocBuilder<ChatBloc, ChatState>(
                          builder: (context, state) {
                            return Visibility(
                              visible: true,
                              // visible: !state.isTyping!,
                              // add here the widget to show while typing
                              replacement: const SizedBox.shrink(),
                              child: Icon(
                                Icons.send_rounded,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 16.w,
                                // size: 16,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  if (state.isLoading!)
                    const TypingIndicator(
                      bubbleAlignment: BubbleRtlAlignment.left,
                      showIndicator: true,
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
