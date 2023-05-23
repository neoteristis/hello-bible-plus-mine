import 'package:flutter/material.dart';
import 'package:gpt/features/chat/presentation/widgets/category_item_widget.dart';

import '../../domain/entities/entities.dart';

class CategoriesBySectionWidget extends StatelessWidget {
  const CategoriesBySectionWidget({super.key, this.data});

  final CategoriesBySection? data;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const SizedBox.shrink();
    }
    final categories = data?.categories;
    return Column(
      children: [
        Text(data!.sectionName),
        if (categories != null && categories.isNotEmpty)
          Column(
            children: [
              ...categories
                  .map(
                    (e) => CategoryItemWidget(
                      category: e,
                    ),
                  )
                  .toList()
            ],
          ),
      ],
    );
  }
}
