import 'package:flutter/material.dart';
import 'package:gpt/core/extension/string_extension.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/entities.dart';

class HistoricalItemWidget extends StatelessWidget {
  const HistoricalItemWidget({super.key, required this.historic});

  final HistoricalConversation historic;

  @override
  Widget build(BuildContext context) {
    final catName = historic.category?.name;
    return ListTile(
      leading: const Icon(Icons.history_rounded),
      title: Text(
        (historic.title ?? 'historique').removeBackSlashN,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            (catName ?? '').removeBackSlashN,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          if (historic.createdAt != null)
            Text(
              DateFormat('dd/MM/y HH:mm').format(historic.createdAt!),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
        ],
      ),
      subtitleTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      // subtitle: historic.messages.isNotEmpty
      //     ? Text(
      //         DateFormat('d/M/y HH:mm')
      //             // .add_jm()
      //             .format(historic.messages.last.createdAt!),
      //         style: Theme.of(context).textTheme.bodySmall,
      //         // historic.messages.last.createdAt.toString(),
      //       )
      //     : null,
    );
  }
}
