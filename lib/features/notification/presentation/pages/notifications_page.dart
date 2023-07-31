import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/scaffold_with_background.dart';
import 'package:gpt/features/chat/presentation/widgets/categories_widget.dart';
import 'package:gpt/features/container/pages/section/presentation/pages/section_page.dart';
import 'package:gpt/features/notification/presentation/pages/manage_notifications_page.dart';
import 'package:gpt/features/notification/presentation/widgets/notification_item_widget.dart';
import '../../../../core/extension/datetime_extension.dart';

import '../bloc/notification_bloc.dart';

class NotificationsPage extends StatefulWidget {
  static const String route = 'notification';

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
        context.go('/${SectionPage.route}');
      },
      title: 'Mes notifications',
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () {
              context.go(
                  '/${NotificationsPage.route}/${ManageNotificationsPage.route}');
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
                  child: const Text(
                    'Tout marquer comme lue',
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const CustomDivider(
            padding: EdgeInsets.zero,
          ),
          Expanded(
            child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                final notifications = state.notifications;

                return ListView(
                  children: [
                    const HeadingSeparatorWidget('Aujourd\'hui'),
                    ...notifications!.map(
                      (e) {
                        if (e.createdAt!.isAtSameDateAsNow) {
                          return NotificationItemWidget(notificationEntity: e);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const HeadingSeparatorWidget('Anciennes'),
                    ...notifications.map(
                      (e) {
                        if (!e.createdAt!.isAtSameDateAsNow) {
                          return NotificationItemWidget(notificationEntity: e);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class HeadingSeparatorWidget extends StatelessWidget {
  const HeadingSeparatorWidget(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 18,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
