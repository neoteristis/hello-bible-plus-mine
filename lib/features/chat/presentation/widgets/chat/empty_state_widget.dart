import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/chat_bloc.dart';

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
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Spacer(
            //   flex: 6,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                minVerticalPadding: 40,
                // visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
                contentPadding: EdgeInsets.zero,
                // leading: const Logo(
                //   size: Size(22, 22),
                // ),
                title: Text(
                  state.conversation!.category?.name ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitle: Text(
                  state.conversation!.category?.welcomePhrase ?? '',
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
