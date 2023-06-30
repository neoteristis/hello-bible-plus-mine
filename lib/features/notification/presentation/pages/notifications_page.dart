import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/scaffold_with_background.dart';
import 'package:gpt/features/chat/presentation/widgets/categories_widget.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../l10n/function.dart';
import '../widgets/notif_manage_item_widget.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      addBackgroundImage: false,
      onPop: () {
        context.pop();
      },
      title: 'Mes notifications',
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () {
              context.go(RouteName.manageNotif);
            },
            child: const Row(
              children: [
                Text('Gérer'),
                SizedBox(
                  width: 3,
                ),
                Icon(Icons.settings),
              ],
            ),
          ),
        ),
      ],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Non lues (0)',
                ),
                TextButton(
                  child: const Text('Tout marquer comme lue'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const CustomDivider(
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
