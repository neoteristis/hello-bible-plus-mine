import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/status.dart';
import '../../bloc/chat_bloc/chat_bloc.dart';
import 'suggestion_item.dart';

class Suggestions extends StatelessWidget {
  const Suggestions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) =>
          previous.suggestions != current.suggestions ||
          previous.isLoading != current.isLoading,
      builder: (context, state) {
        final suggestions = state.suggestions;
        final isChatGenerating = state.isLoading;
        if (suggestions == null || isChatGenerating!) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 20,
          ),
          margin: const EdgeInsets.only(top: 15.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Column(
            children: [
              if (state.suggestionStatus == Status.loading)
                ...List.generate(
                  2,
                  (index) => const SuggestionItemLoading(),
                ),
              if (state.suggestionStatus == Status.loaded)
                if (suggestions.isEmpty) const SizedBox.shrink(),
              if (suggestions.isNotEmpty)
                ...suggestions.map(
                  (e) => SuggestionItem(e),
                ),
            ],
          ),
        );
      },
    );
  }
}
