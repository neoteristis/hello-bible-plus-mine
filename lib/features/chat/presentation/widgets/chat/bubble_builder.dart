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
        // ScreenUtil.init(context, designSize: const Size(360, 690));
        final senderContainer = Theme.of(context).primaryColor;
        final receiverContainer = Theme.of(context).colorScheme.onPrimary;
        final receiverContent = Theme.of(context).colorScheme.secondary;
        final senderContent = Theme.of(context).colorScheme.onPrimary;
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
                        // .toString(),
                        .toLocal(),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 8.sp,
                    // fontSize: 8,
                    color: receiverContent,
                  ),
                ),
                if (state.sender!.id == message.author.id)
                  Icon(
                    Icons.check,
                    size: 12.sp,
                    // size: 12,
                    color: receiverContent,
                  ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: CustomBubble(
                color: state.sender!.id == message.author.id
                    ? senderContainer
                    : receiverContainer,
                nip: state.sender!.id != message.author.id
                    ? BubbleNip.leftBottom
                    : BubbleNip.rightBottom,
                message: message.type == types.MessageType.text
                    ? Text(
                        message.text,
                        // textScaleFactor: 1.2,
                        style: TextStyle(
                          color: state.sender!.id != message.author.id
                              ? receiverContent
                              : senderContent,
                          fontSize: 13.sp,
                          // fontSize: 13,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : child,
              ),
            ),
          ],
        );
      },
    );
