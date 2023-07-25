import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gpt/core/widgets/typing_indicator.dart';
// import 'package:gpt/features/flutter_chat_lib/src/models/bubble_rtl_alignment.dart';
// import '../../../../../core/constants/status.dart';
import '../../../../../core/constants/status.dart';
import '../../../../../core/helper/unfocus_keyboard.dart';
import '../../../../../core/theme/theme.dart';
// import '../../../../flutter_chat_lib/src/widgets/typing_indicator.dart';
import '../../bloc/chat_bloc/chat_bloc.dart';
// import '../typing_indicator.dart';
// import 'list_bottom_chat_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    final hintColor = Theme.of(context)
        .colorScheme
        .onBackground
        .withOpacity(isLight(context) ? 1 : .7);

    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) =>
          previous.focusNode != current.focusNode ||
          previous.isLoading != current.isLoading ||
          previous.readOnly != current.readOnly ||
          previous.textFieldKey != current.textFieldKey ||
          previous.messageStatus != current.messageStatus,
      builder: (context, state) {
        if (state.readOnly == true) {
          return const SizedBox.shrink();
        }
        return Column(
          key: state.textFieldKey,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // if (state.isLoading!)
            //   ChatActionButton(
            //     icon: const Icon(Icons.stop),
            //     label: 'Arrêter',
            //     onPressed: () {
            //       context.read<ChatBloc>().add(ChatStreamCanceled());
            //     },
            //   ),
            if (
                // !state.isLoading! &&
                //   state.messages!.isNotEmpty &&
                state.messageStatus == Status.failed)
              ChatActionButton(
                onPressed: () {
                  context.read<ChatBloc>().add(ChatAnswerRegenerated());
                },
                icon: const Icon(Icons.refresh_rounded),
                label: 'Regénerer',
              ),
            Container(
              padding: const EdgeInsets.only(
                top: 25,
                left: 15,
                right: 15,
                bottom: 25,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLines: 5,
                          minLines: 1,
                          textInputAction: TextInputAction.newline,
                          // keyboardType: TextInputType.text,
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
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            hintText: state.conversation?.category?.placeholder,
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              // fontSize: 14,
                              color: hintColor,
                            ),
                            suffixIcon: state.isLoading!
                                ? const TypingIndicatorWidget()
                                : null,
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24)),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2.w,
                                // width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24)),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2.w,
                                // width: 2,
                              ),
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
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    size: 16.w,
                                    // size: 16,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      if (state.isLoading ?? false)
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: IconButton(
                            onPressed: () {
                              context
                                  .read<ChatBloc>()
                                  .add(ChatStreamCanceled());
                            },
                            icon: const Icon(Icons.stop_rounded),
                          ),
                        ),
                      // const TypingIndicatorWidget()
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ChatActionButton extends StatelessWidget {
  const ChatActionButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
  });

  final String label;
  final Widget? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final backGroundColor = isLight(context)
        ? Theme.of(context).scaffoldBackgroundColor
        : Theme.of(context).colorScheme.background;
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(backgroundColor: backGroundColor),
        onPressed: onPressed,
        icon: icon ?? const SizedBox.shrink(),
        label: Text(label),
      ),
    );
  }
}
