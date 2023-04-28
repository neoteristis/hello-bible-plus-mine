import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/helper/unfocus_keyboard.dart';
import '../../domain/entities/entities.dart';
import '../bloc/chat_bloc.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    this.category,
  });

  final Category? category;

  @override
  Widget build(BuildContext context) {
    if (category == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: category?.colorTheme?.withOpacity(1) ?? ColorConstants.primary,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF202040).withOpacity(0.08),
              offset: const Offset(0, 8),
              blurRadius: 16,
              spreadRadius: 0,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            context.read<ChatBloc>().scaffoldKey.currentState?.closeDrawer();
            unfocusKeyboard();
            context.read<ChatBloc>().add(
                  ChatConversationChanged(
                    category!,
                  ),
                );
          },
          splashColor: Theme.of(context).primaryColor,
          highlightColor: Colors.black.withOpacity(.5),
          child: ListTile(
            splashColor: Theme.of(context).primaryColor,
            title: Text(
              category!.name ?? 'non défini',
              // 'This is a a long category name for you to test it better this is even longer than that',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
