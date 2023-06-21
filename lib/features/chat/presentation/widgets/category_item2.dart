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
    return InkWell(
      onTap: () {
        context.read<ChatBloc>().scaffoldKey.currentState?.closeDrawer();
        unfocusKeyboard();
        context.read<ChatBloc>().add(
              ChatConversationChanged(
                category,
              ),
            );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: category.logo != null ? Colors.black : Colors.green,
          image: category.logo != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(category.logo!),
                  // AssetImage(image),
                  opacity: 0.8,
                )
              : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxis,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Text(
                  category.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  category.welcomePhrase ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
