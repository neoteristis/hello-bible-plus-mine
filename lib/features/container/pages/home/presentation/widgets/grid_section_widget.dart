import 'package:flutter/material.dart';
import 'package:gpt/core/theme/theme.dart';

import 'dart:math' as math;

import 'package:gpt/features/chat/domain/entities/entities.dart';
import 'package:gpt/features/chat/presentation/widgets/category_item2.dart';

import 'category_item_widget.dart';

class GridSectionWidget extends StatelessWidget {
  const GridSectionWidget({
    super.key,
    this.data,
    required this.index,
  });

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
    if (sectionId == '64ba9f74a8bccd0239a4b4e6') {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  sectionName!,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 17,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          if (categories != null && categories.isNotEmpty
              // &&
              //     sectionId != '646b6b8e70c60193c897fc3d'
              )
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: GridView.builder(
                // separatorBuilder: (context, index) => const SizedBox(
                //   width: 8,
                // ),
                // scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 6 / 6,
                  crossAxisSpacing: 4,
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
          // if (categories != null &&
          //     categories.isNotEmpty &&
          //     sectionId == '646b6b8e70c60193c897fc3d')
          //   Padding(
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 10.0,
          //     ),
          //     child: GridView.builder(
          //       physics: const NeverScrollableScrollPhysics(),
          //       shrinkWrap: true,
          //       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          //         maxCrossAxisExtent: 200,
          //         childAspectRatio: 11 / 7,
          //         crossAxisSpacing: 10,
          //         mainAxisSpacing: 10,
          //       ),
          //       itemCount: categories.length,
          //       itemBuilder: (BuildContext ctx, index) {
          //         return CategoryItem2(
          //           category: categories[index],
          //           // image: images[index],
          //         );
          //       },
          //     ),
          //   ),
        ],
      ),
    );
  }
}

// const images = [
//   'assets/images/pray.jpg',
//   'assets/images/pray_3.jpg',
//   'assets/images/pray_2.webp',
//   'assets/images/pray_4.jpg',
// ];

const double iconSize = 16;

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
        ),
      ),
    ];
