import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
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
                  DateFormat('h:mm a').format(
                    DateTime.fromMicrosecondsSinceEpoch(message.createdAt),
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 8,
                    color: Color(0xFF101520),
                  ),
                ),
                if (state.sender!.id == message.author.id)
                  const Icon(Icons.check, size: 12, color: Color(0xFF101520)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            CustomBubble(
              color: state.sender!.id == message.author.id
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              nip: state.sender!.id != message.author.id
                  ? BubbleNip.leftBottom
                  : BubbleNip.rightBottom,
              message: message.type == types.MessageType.text
                  ? Text(
                      message.text,
                      style: TextStyle(
                        color: state.sender!.id != message.author.id
                            ? Colors.black
                            : Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : child,
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
