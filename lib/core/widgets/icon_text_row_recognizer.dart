import 'package:flutter/material.dart';

class IconTextRowRecognizer extends StatelessWidget {
  const IconTextRowRecognizer({
    super.key,
    this.onTap,
    required this.icon,
    required this.label,
  });

  final VoidCallback? onTap;
  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(
            height: 5,
          ),
          Text(label),
        ],
      ),
    );
  }
}
