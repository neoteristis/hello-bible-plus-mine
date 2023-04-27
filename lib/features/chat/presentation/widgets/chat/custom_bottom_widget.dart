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

  @override
  Widget build(BuildContext context) {
    return
        // Padding(
        //   padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Expanded(
        //         child: ExpansionTile(
        //           iconColor: Theme.of(context).primaryColor,
        //           collapsedIconColor: Theme.of(context).primaryColor,
        //           title:
        TextField(
      onChanged: (value) {
        setState(() {});
      },
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
            icon: Icon(
              Icons.send_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        hintText: 'Ecrivez-ici . . . ',
        hintStyle:
            TextStyle(color: Theme.of(context).primaryColor.withOpacity(.7)),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none),
      ),
    )

        // ),
        //         children: [
        //           BlocBuilder<ChatBloc, ChatState>(
        //             buildWhen: (previous, current) =>
        //                 previous.streamMessage != current.streamMessage,
        //             builder: (context, state) {
        //               return SwitchListTile.adaptive(
        //                 activeColor: Theme.of(context).primaryColor,
        //                 contentPadding: const EdgeInsets.only(left: 18, right: 0),
        //                 value: state.streamMessage ?? true,
        //                 onChanged: (value) {
        //                   context
        //                       .read<ChatBloc>()
        //                       .add(ChatMessageModChanged(value: value));
        //                 },
        //                 title: Text(
        //                   'Message en streaming',
        //                   softWrap: false,
        //                   overflow: TextOverflow.visible,
        //                   style: Theme.of(context).textTheme.bodySmall,
        //                 ),
        //               );
        //             },
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        ;
  }
}
