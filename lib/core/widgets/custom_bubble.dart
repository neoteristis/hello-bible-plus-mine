import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/widgets/custom_hero_focused.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:selectable/selectable.dart';
import 'package:share_plus/share_plus.dart';

import '../../features/chat/domain/entities/entities.dart';

import 'custom_focused_menu.dart';

import '../helper/show_text_selection.dart';

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
  final selectionController = SelectableController();

  @override
  void dispose() {
    super.dispose();
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
    final message = widget.textMessage?.content;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: widget.nip == BubbleNip.leftBottom
          ? CustomHeroFocused(
              menuItems: <FocusedMenuItem>[
                // if (widget.indexMessage != 0)
                FocusedMenuItem(
                  title: const Text('Regénérer'),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  title: const Text('Lire'),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  trailingIcon: const Icon(Icons.volume_up_rounded),
                  onPressed: () {
                    context
                        .read<ChatBloc>()
                        .add(ChatMessageReadStarted(messsage: message));
                  },
                ),
                if (message != null)
                  FocusedMenuItem(
                    title: const Text('Copier'),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    trailingIcon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: message,
                        ),
                      );
                    },
                  ),
                FocusedMenuItem(
                  title: const Text(
                    'Sélectionner le texte',
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  trailingIcon: const Icon(Icons.crop_rounded),
                  onPressed: () async {
                    if (message != null) {
                      showTextSelection(
                        context: context,
                        selectionController: selectionController,
                        text: message,
                      );
                      await Future.delayed(
                        const Duration(milliseconds: 500),
                        () {
                          // setState(() {
                          selectionController.selectAll();
                          // });
                        },
                      );
                    }
                  },
                ),
                if (message != null)
                  FocusedMenuItem(
                    title: const Text('Partager'),
                    trailingIcon: const Icon(Icons.share),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    onPressed: () async {
                      await Share.share(
                        message,
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
                      ? Border.all(
                          color: const Color(0xFF232628),
                          width: 1,
                        )
                      : Border.all(
                          color: const Color(0xFFF5F5F5),
                          width: 1,
                        ),
                  color: widget.color,
                  borderRadius: borderRadius,
                ),
                child: Padding(
                  padding: widget.padding ?? const EdgeInsets.all(10.0),
                  child: widget.message ??
                      Text(
                        widget.textMessage?.content ?? '',
                        style: TextStyle(
                          color: widget.textMessage?.role == Role.user
                              ? senderContent
                              : receiverContent,
                          fontSize: 17,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
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
                      cursorColor: Colors.grey,
                      style: TextStyle(
                        color: widget.textMessage?.role == Role.user
                            ? senderContent
                            : receiverContent,
                        fontSize: 17,
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

class CustomBubbleBuilder extends StatelessWidget {
  const CustomBubbleBuilder({
    super.key,
    required this.message,
    required this.context,
    this.index,
  });

  final TextMessage message;
  final BuildContext context;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final senderContainer = Theme.of(context).primaryColor.withOpacity(0.8);
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
              ),
            ),
          ],
        );
      },
    );
  }
}
