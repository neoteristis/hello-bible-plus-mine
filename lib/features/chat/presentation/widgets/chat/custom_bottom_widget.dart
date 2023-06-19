import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                  hintText: 'Ecrivez votre message',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF223159).withOpacity(.7),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2.w),
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
                    return Visibility(
                      visible: true,
                      // visible: !state.isTyping!,
                      // add here the widget to show while typing
                      replacement: const SizedBox.shrink(),
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 16.w,
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
