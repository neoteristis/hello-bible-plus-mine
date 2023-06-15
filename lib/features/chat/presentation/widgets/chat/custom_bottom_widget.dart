import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/unfocus_keyboard.dart';
import '../../bloc/chat_bloc.dart';

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
    return BlocSelector<ChatBloc, ChatState, FocusNode>(
      selector: (state) {
        return state.focusNode!;
      },
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {});
                },
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                focusNode: state,
                controller: textEditingController ?? TextEditingController(),
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(left: 20),
                  // suffixIcon: Visibility(
                  //   visible: textEditingController!.text.isNotEmpty,
                  //   child: IconButton(
                  //     onPressed: () {
                  //       unfocusKeyboard();
                  //       context.read<ChatBloc>().add(
                  //             ChatMessageSent(
                  //               textEditingController!.text,
                  //             ),
                  //           );

                  //       textEditingController!.clear();
                  //     },
                  //     icon: BlocBuilder<ChatBloc, ChatState>(
                  //       builder: (context, state) {
                  //         return Visibility(
                  //           visible: !state.isTyping!,
                  //           // add here the widget to show while typing
                  //           replacement: const SizedBox.shrink(),
                  //           child: Icon(
                  //             Icons.send_rounded,
                  //             color: Theme.of(context).primaryColor,
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  hintText: 'Ecrivez votre message',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF223159).withOpacity(.7),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: IconButton(
                onPressed: () {
                  unfocusKeyboard();
                  context.read<ChatBloc>().add(
                        ChatMessageSent(
                          textEditingController!.text,
                        ),
                      );

                  textEditingController!.clear();
                },
                icon: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    return const Visibility(
                      visible: true,
                      // visible: !state.isTyping!,
                      // add here the widget to show while typing
                      replacement: SizedBox.shrink(),
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
