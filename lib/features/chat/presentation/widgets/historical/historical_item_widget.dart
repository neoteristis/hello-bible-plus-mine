import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/entities.dart';

class HistoricalItemWidget extends StatelessWidget {
  const HistoricalItemWidget({super.key, required this.historic});

  final HistoricalConversation historic;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.message_rounded),
      title: Text(historic.title ?? historic.idString ?? 'nothing to show'),
      subtitle: historic.messages.isNotEmpty
          ? Text(
              DateFormat('d/M/y HH:mm')
                  // .add_jm()
                  .format(historic.messages.last.createdAt!),
              style: Theme.of(context).textTheme.bodySmall,
              // historic.messages.last.createdAt.toString(),
            )
          : null,
    );
  }
}
