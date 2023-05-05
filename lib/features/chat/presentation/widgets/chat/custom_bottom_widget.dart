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
        return TextField(
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
            contentPadding: const EdgeInsets.only(left: 8),
            suffixIcon: Visibility(
              visible: textEditingController!.text.isNotEmpty,
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
                    return Visibility(
                      visible: !state.isTyping!,
                      // add here the widget to show while typing
                      replacement: const SizedBox.shrink(),
                      child: Icon(
                        Icons.send_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  },
                ),
              ),
            ),
            hintText: 'Ecrivez-ici . . . ',
            hintStyle: TextStyle(
                color: Theme.of(context).primaryColor.withOpacity(.7)),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none),
          ),
        );
      },
    );
  }
}
