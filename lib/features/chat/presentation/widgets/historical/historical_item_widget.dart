import 'package:flutter/material.dart';
import 'package:gpt/core/extension/string_extension.dart';

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
      subtitle: Text(
        (catName ?? '').removeBackSlashN,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitleTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
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
