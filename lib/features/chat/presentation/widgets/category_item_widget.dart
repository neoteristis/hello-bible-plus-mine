import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt/core/widgets/custom_network_image.dart';

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
    if (category == null) {
      return const SizedBox.shrink();
    }
    final logo = category?.logo;
    final contentColor = Theme.of(context).colorScheme.secondary;
    final colorTheme = category?.colorTheme;
    final isLight =
        Theme.of(context).colorScheme.brightness == Brightness.light;
    final background = Theme.of(context).colorScheme.onPrimary;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isLight ? colorTheme ?? background : background,
        border: Border.fromBorderSide(
            BorderSide(color: Theme.of(context).dividerColor)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF202040).withOpacity(0.08),
            offset: const Offset(4, 4),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          context.read<ChatBloc>().scaffoldKey.currentState?.closeDrawer();
          unfocusKeyboard();
          context.read<ChatBloc>().add(
                ChatConversationChanged(
                  category: category!,
                ),
              );
        },
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Colors.black.withOpacity(.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8,
            ),
            if (logo != null)
              CustomNetworkImage(
                logo,
                color: contentColor,
              ),
            if (logo == null)
              const SizedBox(
                height: 8,
              ),
            if (logo != null)
              const SizedBox(
                height: 4,
              ),
            Expanded(
              flex: 2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Text(
                    category?.name ?? '',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 11.sp,
                          letterSpacing: 0.0,
                          height: 1.2,
                          // fontSize: 11,
                        ),
                    // style: TextStyle(
                    //   fontWeight: FontWeight.w700,
                    //   fontSize: 11,
                    //   // fontSize: 11,
                    //   color: contentColor,
                    // ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 2,
            // ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Text(
                  category?.welcomePhrase ?? '',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,

                  // style: TextStyle(
                  //   fontWeight: FontWeight.w500,
                  //   fontSize: 11,
                  //   color: contentColor,
                  // ),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                        letterSpacing: 0.0,
                        height: 1.2,
                        // fontSize: 11,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
