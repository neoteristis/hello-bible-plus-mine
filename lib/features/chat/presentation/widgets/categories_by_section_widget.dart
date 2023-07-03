import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gpt/features/chat/presentation/widgets/category_item_widget.dart';

import '../../domain/entities/entities.dart';
import 'dart:math' as math;

import 'category_item2.dart';

class CategoriesBySectionWidget extends StatelessWidget {
  const CategoriesBySectionWidget({super.key, this.data, required this.index});

  final CategoriesBySection? data;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const SizedBox.shrink();
    }
    final categories = data?.categories;
    final sectionName = data?.sectionName;
    final sectionId = data?.id;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            iconLeadings(context)[index],
            const SizedBox(
              width: 5,
            ),
            Text(
              sectionName!,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                // fontSize: 14,
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.9),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (categories != null &&
            categories.isNotEmpty &&
            sectionId != '646b6b8e70c60193c897fc3d')
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.builder(
              // separatorBuilder: (context, index) => const SizedBox(
              //   width: 8,
              // ),
              // scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 6 / 8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                // if (index == 0) {
                //   return Row(
                //     children: [
                //       const SizedBox(
                //         width: 20,
                //       ),
                //       CategoryItemWidget(
                //         category: categories[index],
                //       )
                //     ],
                //   );
                // } else if (index == categories.length - 1) {
                //   return Row(
                //     children: [
                //       CategoryItemWidget(
                //         category: categories[index],
                //       ),
                //       const SizedBox(
                //         width: 20,
                //       ),
                //     ],
                //   );
                // }
                return CategoryItemWidget(
                  category: categories[index],
                );
              },
            ),
          ),
        if (categories != null &&
            categories.isNotEmpty &&
            sectionId == '646b6b8e70c60193c897fc3d')
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 11 / 7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: categories.length,
              itemBuilder: (BuildContext ctx, index) {
                return CategoryItem2(
                  category: categories[index],
                  // image: images[index],
                );
              },
            ),
          ),
      ],
    );
  }
}

// const images = [
//   'assets/images/pray.jpg',
//   'assets/images/pray_3.jpg',
//   'assets/images/pray_2.webp',
//   'assets/images/pray_4.jpg',
// ];

final double iconSize = 16;

List<Widget> iconLeadings(BuildContext context) => [
      Icon(
        Icons.square_rounded,
        size: iconSize,
        color: Theme.of(context).primaryColor,
      ),
      Icon(
        Icons.circle,
        size: iconSize,
        color: Theme.of(context).primaryColor,
      ),
      Transform.rotate(
          angle: math.pi / 4,
          child: Icon(
            Icons.square_rounded,
            size: iconSize,
            color: Theme.of(context).primaryColor,
          )),
    ];
