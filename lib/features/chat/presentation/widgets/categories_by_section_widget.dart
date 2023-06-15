import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gpt/features/chat/presentation/widgets/category_item_widget.dart';

import '../../domain/entities/entities.dart';
import 'dart:math' as math;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            iconLeadings[index],
            const SizedBox(
              width: 3,
            ),
            Text(
              data!.sectionName,
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
        if (categories != null && categories.isNotEmpty)
          SizedBox(
            height: 110,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: 8,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => CategoryItemWidget(
                category: categories[index],
              ),
            ),
          ),
        // Column(
        //   children: [
        //     ...categories
        //         .map(
        //           (e) => CategoryItemWidget(
        //             category: e,
        //           ),
        //         )
        //         .toList()
        //   ],
        // ),
      ],
    );
  }
}

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
