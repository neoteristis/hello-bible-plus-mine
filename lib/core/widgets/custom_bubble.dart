import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../features/chat/domain/entities/entities.dart';
import '../../features/chat/presentation/bloc/chat_bloc.dart';

class CustomBubble extends StatelessWidget {
  const CustomBubble({
    super.key,
    required this.message,
    this.nip = BubbleNip.no,
    // this.textColor = Colors.black,
    this.color = Colors.white,
    this.radius = 20.0,
    this.padding,
  });

  final Widget message;
  final BubbleNip? nip;
  final Color? color;
  // final Color? textColor;
  final double? radius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry? borderRadius;

    switch (nip) {
      case BubbleNip.leftBottom:
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(
            radius!,
          ),
          topRight: Radius.circular(
            radius!,
          ),
          bottomRight: Radius.circular(
            radius!,
          ),
        );
        break;
      case BubbleNip.rightBottom:
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(
            radius!,
          ),
          topRight: Radius.circular(
            radius!,
          ),
          bottomLeft: Radius.circular(
            radius!,
          ),
        );
        break;
      default:
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(
            radius!,
          ),
          topRight: Radius.circular(
            radius!,
          ),
          bottomLeft: Radius.circular(
            radius!,
          ),
          bottomRight: Radius.circular(
            radius!,
          ),
        );
    }
    final isLight =
        Theme.of(context).colorScheme.brightness == Brightness.light;
    return Container(
      // constraints:
      //     BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * .9),
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000)
                .withOpacity(0.1), // shadow color with opacity
            spreadRadius: 0, // spread radius
            blurRadius: 10, // blur radius
            offset: const Offset(0, 4), // offset in x and y direction
          ),
        ],
        border: !isLight
            ? Border.all(color: const Color(0xFF232628), width: 1)
            : Border.all(color: const Color(0xFFF5F5F5), width: 1),
        color: color,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(10.0),
        child: message,
      ),
    );
  }
}

enum BubbleNip {
  no,
  leftBottom,
  rightBottom,
}

Widget customBubbleBuilder({
  required TextMessage message,
}) =>
    BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final senderContainer = Theme.of(context).primaryColor;
        final receiverContainer = Theme.of(context).colorScheme.onPrimary;
        final receiverContent = Theme.of(context).colorScheme.secondary;
        final senderContent = Theme.of(context).colorScheme.onPrimary;
        return Column(
          crossAxisAlignment: message.role == Role.user
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            // if (message.createdAt != null)
            //   Align(
            //     alignment: message.role == Role.user
            //         ? Alignment.centerRight
            //         : Alignment.centerLeft,
            //     child: Row(
            //       children: [
            //         Text(
            //           DateFormat.jm().format(message.createdAt!),
            //         ),
            //       ],
            //     ),
            //   ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: CustomBubble(
                nip: message.role == Role.user
                    ? BubbleNip.rightBottom
                    : BubbleNip.leftBottom,
                color: message.role == Role.user
                    ? senderContainer
                    : receiverContainer,
                message: Text(
                  message.content ?? '',
                  // textScaleFactor: 1.2,
                  style: TextStyle(
                    color: message.role == Role.user
                        ? senderContent
                        : receiverContent,
                    fontSize: 17.sp,
                    // fontSize: 13,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
