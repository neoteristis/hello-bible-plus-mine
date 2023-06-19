import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            iconLeadings[index],
            const SizedBox(
              width: 3,
            ),
            Text(
              sectionName!,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: const Color(0xFF223159).withOpacity(.9),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (categories != null &&
            categories.isNotEmpty &&
            sectionName != 'Posez vos questions')
          SizedBox(
            height: 140,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                width: 8,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      CategoryItemWidget(
                        category: categories[index],
                      )
                    ],
                  );
                }
                return CategoryItemWidget(
                  category: categories[index],
                );
              },
            ),
          ),
        if (categories != null &&
            categories.isNotEmpty &&
            sectionName == 'Posez vos questions')
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 9 / 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: categories.length,
              itemBuilder: (BuildContext ctx, index) {
                return CategoryItem2(
                  category: categories[index],
                  image: images[index],
                );
              },
            ),
          )
      ],
    );
  }
}

const images = [
  'assets/images/pray.jpg',
  'assets/images/pray_3.jpg',
  'assets/images/pray_2.webp',
  'assets/images/pray_4.jpg',
];

final double iconSize = 16;

List<Widget> iconLeadings = [
  Icon(
    Icons.square_rounded,
    size: iconSize,
  ),
  Icon(
    Icons.circle,
    size: iconSize,
  ),
  Transform.rotate(
      angle: math.pi / 4,
      child: Icon(
        Icons.square_rounded,
        size: iconSize,
      )),
];
