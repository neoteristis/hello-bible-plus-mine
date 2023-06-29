import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_list_tile.dart';
import 'date_information.dart';

class NotifManageItem extends StatelessWidget {
  const NotifManageItem({
    super.key,
    required this.switchValue,
    required this.logo,
    required this.title,
    required this.hour,
  });
  final bool switchValue;
  final Widget logo;
  final String title;
  final String hour;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: logo,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          switchValue: switchValue,
          description: 'Gérer vos notifications sur ${title.toLowerCase()}',
          onChanged: (value) {},
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Rétablir par défaut',
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
          onTap: () async {
            // context.read<NotificationBloc>().add(
            //       NotificationTimeSelected(context: context),
            //     );
            await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              initialEntryMode: TimePickerEntryMode.input,
              cancelText: 'Annuler',
              hourLabelText: 'Heure',
              helpText: 'Choisissez l\'heure',
            );
          },
          child: DateInformation(
            label: 'Heure',
            info: hour,
          ),
        ),
      ],
    );
  }
}
