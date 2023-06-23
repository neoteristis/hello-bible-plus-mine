import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/widgets/custom_bubble.dart';
import '../../bloc/chat_bloc.dart';
import '../typing_indicator.dart';

class ListBottomChatWidget extends StatelessWidget {
  const ListBottomChatWidget({super.key});

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
            return Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // const BotAvatar(),
                  // if (!state.isTyping!)
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
                            fontSize: 13.sp,
                            height: 1.4,
                            fontWeight: FontWeight.w400,
                          ),
                          // textAlign: TextAlign.justify,
                          // style: TextStyle(
                          //   color: Theme.of(context).primaryColor,
                          // ),
                        )
                        // child: Markdown(
                        //   padding: EdgeInsets.zero,
                        //   shrinkWrap: true,
                        //   softLineBreak: true,
                        //   data: state.incoming ?? '',
                        // )
                        // child: TextFormField(
                        //   cursorColor: Theme.of(context).primaryColor,
                        //   enabled: false,
                        //   minLines: 1,
                        //   maxLines: null,
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyMedium
                        //       ?.copyWith(color: Theme.of(context).primaryColor),
                        //   controller: state.textEditingController,
                        //   decoration: const InputDecoration(
                        //       border: InputBorder.none,
                        //       contentPadding: EdgeInsets.zero),
                        // ),
                        ),
                  ),
                  // if (!state.isTyping!)
                  //   Expanded(child: TypingIndicator(showIndicator: true)),
                  // const Spacer(
                  //   flex: 1,
                  // ),
                ],
              ),
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
