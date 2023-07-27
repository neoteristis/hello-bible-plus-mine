import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInformation extends StatelessWidget {
  const DateInformation({
    super.key,
    required this.label,
    this.info,
  });

  final String label;
  final DateTime? info;

  @override
  Widget build(BuildContext context) {
    final hour = info?.toLocal();
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
          if (hour != null)
            Text(
              DateFormat('HH:mm').format(hour),
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          const Icon(Icons.arrow_drop_down_rounded),
        ],
      ),
    );
  }
}
