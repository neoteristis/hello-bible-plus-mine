import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../l10n/function.dart';
import '../../domain/entities/notif_by_category.dart';
import 'custom_list_tile.dart';
import 'date_information.dart';
import 'icon_logo_notif_widget.dart';

class NotifManageItem extends StatelessWidget {
  const NotifManageItem(
    this.notif, {
    super.key,
    this.onTap,
  });
  final NotificationTime notif;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final title = notif.title == '{{data}}'
        ? 'Thème aléatoire'
        : notif.title ?? 'Notification';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomListTile(
          leading: const IconLogoNotifWidget(
            icon: Icon(
              Icons.notifications,
              size: 18,
            ),
            radius: 15,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: DateInformation(
            label: 'Heure de la notification',
            info: notif.time,
          ),
        ),
        // ListTile(
        //   contentPadding: EdgeInsets.zero,
        //   title: Text(
        //     dict(context).resetToDefault,
        //     style: TextStyle(
        //       color: Theme.of(context).colorScheme.tertiary,
        //       fontWeight: FontWeight.w500,
        //       fontSize: 14,
        //     ),
        //   ),
        //   trailing: Transform.scale(
        //     scale: 0.8,
        //     origin: const Offset(50, 0),
        //     child: CupertinoSwitch(
        //       value: false,
        //       onChanged: (_) {},
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
