import 'package:flutter/material.dart';

import 'categories_widget.dart';

class ContainerCategoriesWidget extends StatelessWidget {
  const ContainerCategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF202040).withOpacity(0.08),
              offset: const Offset(0, 8),
              blurRadius: 16,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoriesWidget(
              isWhite: true,
            ),
          ],
        ),
      ),
    );
  }
}
