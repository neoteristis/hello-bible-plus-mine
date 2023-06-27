import 'package:flutter/material.dart';

class DateInformation extends StatelessWidget {
  const DateInformation({
    super.key,
    required this.label,
    this.info,
  });

  final String label;
  final String? info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        // horizontal: 15,
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Text(info ?? ''),
        ],
      ),
    );
  }
}
