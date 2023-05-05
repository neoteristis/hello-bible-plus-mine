import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        String? welcomePhrase;
        try {
          welcomePhrase = state.categories
              ?.firstWhere(
                  (element) => element.id == state.conversation?.category?.id)
              .welcomePhrase;
        } catch (_) {
          welcomePhrase = 'Bonjour. Comment puis-je vous aider ?';
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  welcomePhrase == null || welcomePhrase == ''
                      ?
                      // state.conversation!.category!.welcomePhrase ??
                      'Bonjour. Comment puis-je vous aider ?'
                      : welcomePhrase,
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
                const SizedBox(
                  height: 10,
                ),
                const CustomBottomWidget()
              ],
            ),
          ),
        );
      },
    );
  }
}
