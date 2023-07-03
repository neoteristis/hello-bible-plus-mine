import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt/core/widgets/custom_network_image.dart';

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
    final logo = category?.logo;
    final contentColor = Theme.of(context).colorScheme.secondary;
    return Container(
      // width: 100.sp,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.onPrimary,
        border: Border.fromBorderSide(
            BorderSide(color: Theme.of(context).dividerColor)),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8,
            ),
            if (logo != null)
              CustomNetworkImage(
                logo,
                color: contentColor,
              ),
            if (logo == null)
              Expanded(
                child: SvgPicture.asset(
                  'assets/icons/ichthys.svg',
                  width: 25.sp,
                  // width: 25,
                  color: contentColor,
                ),
              ),
            SizedBox(
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
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 11.sp,
                      // fontSize: 11,
                      color: contentColor,
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 4,
            // ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: Text(
                  category?.welcomePhrase ?? '',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 11.sp,
                    // fontSize: 11,
                    color: contentColor,
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
