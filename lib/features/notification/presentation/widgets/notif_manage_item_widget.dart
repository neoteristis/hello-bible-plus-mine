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
  final NotifByCategory notif;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomListTile(
          leading: IconLogoNotifWidget(
            icon: SvgPicture.asset(
              notif.iconPath!,
              color: Colors.white,
            ),
          ),
          title: Text(
            notif.title!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          switchValue: notif.value,
          description:
              '${dict(context).handleYourNotifOn}${notif.title!.toLowerCase()}',
          onChanged: (value) {},
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            dict(context).resetToDefault,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          trailing: Transform.scale(
            scale: 0.8,
            origin: const Offset(50, 0),
            child: CupertinoSwitch(
              value: false,
              onChanged: (_) {},
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: DateInformation(
            label: dict(context).hour,
            info: notif.time,
          ),
        ),
      ],
    );
  }
}
