import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../bloc/chat_bloc.dart';

Widget bubbleBuilder(
  Widget child, {
  required message,
  required nextMessageInGroup,
}) =>
    BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Bubble(
          radius: const Radius.circular(20.0),
          color: Colors.white,
          margin: nextMessageInGroup
              ? const BubbleEdges.symmetric(horizontal: 6)
              : null,
          nip: nextMessageInGroup
              ? BubbleNip.no
              : state.sender!.id != message.author.id
                  ? BubbleNip.leftBottom
                  : BubbleNip.rightBottom,
          child: message.type == types.MessageType.text
              ? Text(
                  message.text,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                )
              : child,
        );
      },
    );
