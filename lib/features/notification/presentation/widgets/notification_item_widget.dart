import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt/core/extension/datetime_extension.dart';

import '../../domain/entities/notification_entity.dart';
import 'icon_logo_notif_widget.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({
    super.key,
    required this.notificationEntity,
  });

  final NotificationEntity notificationEntity;
  @override
  Widget build(BuildContext context) {
    final logo = notificationEntity.logo;
    final title = notificationEntity.title;
    final content = notificationEntity.content;
    final isRead = notificationEntity.isRead;
    final createdAt = notificationEntity.createdAt;
    return Container(
      decoration: BoxDecoration(
        color: !isRead!
            ? const Color(
                0xFFEDF2FE,
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: ListTile(
          titleAlignment: ListTileTitleAlignment.top,
          leading: logo != null
              ? IconLogoNotifWidget(
                  radius: 18,
                  icon: SvgPicture.asset(
                    logo,
                    width: 20,
                    color: Colors.white,
                  ),
                )
              : null,
          title: RichText(
            text: TextSpan(
              text: '$title : ',
              style: const TextStyle(color: Color(0xFF646F8B), fontSize: 12),
              children: [
                TextSpan(
                  text: content ?? '',
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                )
              ],
            ),
          ),
          trailing: Text(
            createdAt!.delayPassed,
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
