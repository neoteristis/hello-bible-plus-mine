import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/unfocus_keyboard.dart';
import '../../bloc/chat_bloc.dart';
import 'custom_bottom_widget.dart';

class EmptyStateWidget extends StatefulWidget {
  const EmptyStateWidget({super.key});

  @override
  State<EmptyStateWidget> createState() => _EmptyStateWidgetState();
}

class _EmptyStateWidgetState extends State<EmptyStateWidget> {
  late TextEditingController? textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) =>
          previous.conversation != current.conversation,
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.categories
                          ?.firstWhere((element) =>
                              element.id == state.conversation?.category?.id)
                          .welcomePhrase ??
                      // state.conversation!.category!.welcomePhrase ??
                      'Bonjour. Comment puis-je vous aider ?',
                  // defaultMessage,
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    // color: Color(0xff9e9cab),
                    color: Theme.of(context).primaryColor,
                    // fontSize: 16,
                    // fontWeight: FontWeight.w500,
                    // height: 1.5,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomBottomWidget()
              ],
            ),
          ),
        );
      },
    );
  }
}
