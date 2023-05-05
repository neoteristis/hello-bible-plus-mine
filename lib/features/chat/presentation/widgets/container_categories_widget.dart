import 'package:flutter/material.dart';

import 'categories_widget.dart';

class ContainerCategoriesWidget extends StatelessWidget {
  const ContainerCategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            CategoriesWidget(),
          ],
        ),
      ),
    );
  }
}
