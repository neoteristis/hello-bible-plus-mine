import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/unfocus_keyboard.dart';
import '../../domain/entities/entities.dart';
import '../bloc/chat_bloc.dart';

class CategoryItem2 extends StatelessWidget {
  const CategoryItem2({
    super.key,
    required this.category,
    this.image,
  });

  final Category category;
  final String? image;

  @override
  Widget build(BuildContext context) {
    // final contentColor = Theme.of(context).colorScheme.secondary;
    return InkWell(
      onTap: () {
        context.read<ChatBloc>().scaffoldKey.currentState?.closeDrawer();
        unfocusKeyboard();
        context.read<ChatBloc>().add(
              ChatConversationChanged(
                category,
                context,
              ),
            );
      },
      child: Container(
        // alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          border: Border.fromBorderSide(
              BorderSide(color: Theme.of(context).dividerColor)),
          // color: Theme.of(context).primaryColor,
          // color: category.logo != null ? Colors.black : Colors.green,
          // image: category.logo != null
          //     ? DecorationImage(
          //         fit: BoxFit.cover,
          //         image: NetworkImage(category.logo!),
          //         // AssetImage(image),
          //         opacity: 0.8,
          //       )
          //     : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36.0),
                  child: Text(
                    category.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 14.sp,
                          // fontSize: 14,
                        ),
                    // style: TextStyle(
                    //   fontSize: 14.sp,
                    //   fontWeight: FontWeight.w700,
                    //   color: Colors.white,
                    // ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    category.welcomePhrase ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    // style: TextStyle(
                    //   fontSize: 11.sp,
                    //   fontWeight: FontWeight.w500,
                    //   color: Colors.white,
                    // ),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          // fontSize: 11,
                          fontSize: 11.sp,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 3,
            // ),
          ],
        ),
      ),
    );
  }
}
