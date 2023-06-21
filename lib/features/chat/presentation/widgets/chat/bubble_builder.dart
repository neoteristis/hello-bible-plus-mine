import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/widgets/custom_bubble.dart';
import '../../bloc/chat_bloc.dart';

Widget bubbleBuilder(
  Widget child, {
  required message,
  required bool nextMessageInGroup,
}) =>
    BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        ScreenUtil.init(context, designSize: const Size(360, 690));
        return Column(
          crossAxisAlignment: state.sender!.id == message.author.id
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: state.sender!.id == message.author.id
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat('hh:mm a').format(
                    DateTime.fromMicrosecondsSinceEpoch(message.createdAt,
                            isUtc: false)
                        .toLocal(),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 8.sp,
                    color: Color(0xFF101520),
                  ),
                ),
                if (state.sender!.id == message.author.id)
                  Icon(Icons.check, size: 12.sp, color: Color(0xFF101520)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: CustomBubble(
                color: state.sender!.id == message.author.id
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                nip: state.sender!.id != message.author.id
                    ? BubbleNip.leftBottom
                    : BubbleNip.rightBottom,
                message: message.type == types.MessageType.text
                    ? Text(
                        message.text,
                        // textScaleFactor: 1.2,
                        style: TextStyle(
                          color: state.sender!.id != message.author.id
                              ? Colors.black
                              : Colors.white,
                          fontSize: 13.sp,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : child,
              ),
            ),
          ],
        );
        // return Bubble(
        //   radius: const Radius.circular(20.0),
        //   color: Colors.white,
        //   margin: nextMessageInGroup
        //       ? const BubbleEdges.symmetric(horizontal: 6)
        //       : null,
        //   nip: nextMessageInGroup
        //       ? BubbleNip.no
        //       : state.sender!.id != message.author.id
        //           ? BubbleNip.leftBottom
        //           : BubbleNip.rightBottom,
        //   child: message.type == types.MessageType.text
        //       ? Text(
        //           message.text,
        //           // textAlign: TextAlign.justify,
        //           style: const TextStyle(
        //             color: Colors.black,
        //           ),
        //         )
        //       : child,
        // );
      },
    );
