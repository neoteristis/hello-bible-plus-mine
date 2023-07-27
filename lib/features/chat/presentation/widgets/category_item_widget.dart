import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gpt/core/widgets/custom_network_image.dart';
import 'package:neumorphic_button/neumorphic_button.dart';

import '../../../../core/helper/unfocus_keyboard.dart';
import '../../domain/entities/entities.dart';
import '../bloc/chat_bloc/chat_bloc.dart';

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
      onTap: () {
        context.read<ChatBloc>().scaffoldKey.currentState?.closeDrawer();
        unfocusKeyboard();
        context.read<ChatBloc>().add(
              ChatConversationChanged(
                category: category!,
              ),
            );
      },
      borderRadius: 12.sp,
      backgroundColor: const Color(0xFFF6F6F6),
      topLeftShadowBlurRadius: 10,
      topLeftShadowSpreadRadius: 3,
      topLeftShadowColor: Colors.white,
      bottomRightShadowBlurRadius: 20,
      bottomRightShadowSpreadRadius: 0,
      bottomRightShadowColor: const Color(0xFFD9D9D9),
      height: 80,
      width: 80,
      bottomRightOffset: const Offset(3, 3),
      topLeftOffset: const Offset(-7, -7),
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
            child: Center(
              child: Text(
                category?.name ?? '',
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 11.sp,
                    ),
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Expanded(
            flex: 2,
            child: Text(
              category?.welcomePhrase ?? '',
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    color: const Color(0xFF7B7B7B),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
