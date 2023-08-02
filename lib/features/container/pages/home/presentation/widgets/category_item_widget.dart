import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/extension/string_extension.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';
import 'package:gpt/core/widgets/custom_network_image.dart';
import 'package:gpt/core/widgets/neumorphic_button.dart';
import 'package:gpt/features/chat/domain/entities/entities.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:gpt/features/chat/presentation/pages/chat_page.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    this.category,
  });

  final Category? category;

  @override
  Widget build(BuildContext context) {
    final logo = category?.logo;
    final contentColor = Theme.of(context).colorScheme.secondary;
    if (category == null) {
      return const SizedBox.shrink();
    }
    return NeumorphicButton(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 4.0,
      ),
      onTap: () {
        context.read<ChatBloc>().scaffoldKey.currentState?.closeDrawer();
        unfocusKeyboard();
        context.read<ChatBloc>().add(
              ChatConversationChanged(
                category: category!,
              ),
            );
        final route = '/${ChatPage.route}?previousPage=${GoRouter.of(context).routerDelegate.currentConfiguration.fullPath.replaceAll('/', '')}';
        context.go(route);
      },
      borderRadius: 12,
      splashColor: const Color(0xFFF4F4F4),
      backgroundColor: const Color(0xFFF6F6F6),
      topLeftShadowBlurRadius: 10,
      topLeftShadowSpreadRadius: 0,
      topLeftShadowColor: const Color(0xFFFFFFFF),
      topLeftOffset: const Offset(-7, -7),
      bottomRightShadowBlurRadius: 20,
      bottomRightShadowSpreadRadius: 0,
      bottomRightShadowColor: const Color(0xFFD9D9D9),
      bottomRightOffset: const Offset(3, 3),
      height: 80,
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (logo != null)
            CustomNetworkImage(
              logo,
              color: contentColor,
            ),
          if (logo != null)
            const SizedBox(
              height: 4,
            ),
          Expanded(
            flex: 2,
            child: Text(
              (category?.name ?? '').nextLine,
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Expanded(
            flex: 2,
            child: Text(
              (category?.welcomePhrase ?? '').nextLine,
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                    color: const Color(0xFF7B7B7B),
                    letterSpacing: 0.2,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
