import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:gpt/features/chat/presentation/widgets/custom_selectable_text.dart';
import 'package:selectable/selectable.dart';
import 'package:share_plus/share_plus.dart';

import '../../features/chat/domain/entities/entities.dart';
import '../../features/chat/presentation/bloc/chat_bloc.dart';
import '../helper/log.dart';

class CustomBubble extends StatefulWidget {
  const CustomBubble({
    super.key,
    this.message,
    this.nip = BubbleNip.no,
    // this.textColor = Colors.black,
    this.color = Colors.white,
    this.radius = 20.0,
    this.padding,
    this.textMessage,
    this.messageContent,
    this.indexMessage,
  });

  final Widget? message;
  final BubbleNip? nip;
  final Color? color;
  final TextMessage? textMessage;

  // final Color? textColor;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final String? messageContent;
  final int? indexMessage;

  @override
  State<CustomBubble> createState() => _CustomBubbleState();
}

class _CustomBubbleState extends State<CustomBubble> {
  late final FocusNode focusNode;

  final _selectionController = SelectableController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusNode = FocusNode(skipTraversal: true, canRequestFocus: true);
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry? borderRadius;

    switch (widget.nip) {
      case BubbleNip.leftBottom:
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(
            widget.radius!,
          ),
          topRight: Radius.circular(
            widget.radius!,
          ),
          bottomRight: Radius.circular(
            widget.radius!,
          ),
        );
        break;
      case BubbleNip.rightBottom:
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(
            widget.radius!,
          ),
          topRight: Radius.circular(
            widget.radius!,
          ),
          bottomLeft: Radius.circular(
            widget.radius!,
          ),
        );
        break;
      default:
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(
            widget.radius!,
          ),
          topRight: Radius.circular(
            widget.radius!,
          ),
          bottomLeft: Radius.circular(
            widget.radius!,
          ),
          bottomRight: Radius.circular(
            widget.radius!,
          ),
        );
    }
    final isLight =
        Theme.of(context).colorScheme.brightness == Brightness.light;
    final receiverContent = Theme.of(context).colorScheme.secondary;
    final senderContent = Theme.of(context).colorScheme.onPrimary;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 3,
      ),
      child: widget.nip == BubbleNip.leftBottom
          ? FocusedMenuHolder(
              onPressed: () {},
              menuWidth: MediaQuery.of(context).size.width * 0.50,
              blurSize: 5.0,
              menuOffset: 10,
              menuItemExtent: 45,
              menuBoxDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              duration: const Duration(milliseconds: 100),
              animateMenuItems: true,
              openWithTap: true,
              blurBackgroundColor: Colors.black54,
              // bottomOffsetHeight: 100,
              // openWithTap: true,
              menuItems: <FocusedMenuItem>[
                // if (textMessage?.content != null)
                //   FocusedMenuItem(
                //     title: const Text('Copier'),
                //     trailingIcon: const Icon(Icons.copy),
                //     onPressed: () {
                //       Clipboard.setData(
                //           ClipboardData(text: textMessage?.content ?? ''));
                //     },
                //   ),
                FocusedMenuItem(
                  title: const Text('Regénérer'),
                  trailingIcon: const Icon(Icons.refresh_rounded),
                  onPressed: () {
                    context.read<ChatBloc>().add(
                          ChatAnswerRegenerated(
                            messsageId: widget.indexMessage,
                          ),
                        );
                  },
                ),
                FocusedMenuItem(
                  title: const Text('Sélectionner le texte'),
                  trailingIcon: const Icon(Icons.crop_rounded),
                  onPressed: () {
                    _selectionController.selectAll();
                  },
                ),
                if (widget.textMessage?.content != null)
                  FocusedMenuItem(
                    title: const Text('Partager'),
                    trailingIcon: const Icon(Icons.share),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    onPressed: () async {
                      await Share.share(
                        widget.textMessage?.content ?? '',
                      );
                    },
                  ),
              ],
              child: Container(
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
                  color: widget.color,
                  borderRadius: borderRadius,
                ),
                child: Padding(
                  padding: widget.padding ?? const EdgeInsets.all(10.0),
                  child: Selectable(
                    selectionController: _selectionController,
                    child: widget.message ?? const Text('ggggggggggggggg'),
                  ),
                ),
              ),
            )
          : Container(
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
                color: widget.color,
                borderRadius: borderRadius,
              ),
              child: Padding(
                padding: widget.padding ?? const EdgeInsets.all(10.0),
                child: widget.message ??
                    SelectableText(
                      widget.textMessage?.content ?? '',
                      focusNode: focusNode,
                      style: TextStyle(
                        color: widget.textMessage?.role == Role.user
                            ? senderContent
                            : receiverContent,
                        fontSize: 17.sp,
                        // fontSize: 17,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              ),
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
  required BuildContext context,
  int? index,
}) {
  return BlocBuilder<ChatBloc, ChatState>(
    builder: (context, state) {
      final senderContainer = Theme.of(context).primaryColor;
      final receiverContainer = Theme.of(context).colorScheme.onPrimary;
      // final receiverContent = Theme.of(context).colorScheme.secondary;
      // final senderContent = Theme.of(context).colorScheme.onPrimary;
      return Column(
        crossAxisAlignment: message.role == Role.user
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: CustomBubble(
              indexMessage: index,
              textMessage: message,
              nip: message.role == Role.user
                  ? BubbleNip.rightBottom
                  : BubbleNip.leftBottom,
              color: message.role == Role.user
                  ? senderContainer
                  : receiverContainer,
              messageContent: message.content,
              // message: SelectableText(
              //   message.content ?? '',
              //   style: TextStyle(
              //     color: message.role == Role.user
              //         ? senderContent
              //         : receiverContent,
              //     fontSize: 17.sp,
              //     // fontSize: 17,
              //     height: 1.4,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
            ),
          ),
        ],
      );
    },
  );
}
