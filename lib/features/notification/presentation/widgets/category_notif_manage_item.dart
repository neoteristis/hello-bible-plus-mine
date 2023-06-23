import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/features/notification/presentation/bloc/notification_bloc.dart';

import '../../../../core/widgets/custom_network_image.dart';
import '../../../chat/domain/entities/category.dart';
import '../../domain/entities/notif_by_category.dart';
import 'date_information.dart';

class CategoryNotifManageItem extends StatelessWidget {
  const CategoryNotifManageItem(
    this.category, {
    super.key,
    required this.switchValue,
    this.notifByCat,
  });
  final NotifByCategory? notifByCat;
  final Category? category;
  final bool switchValue;

  @override
  Widget build(BuildContext context) {
    if (category == null) {
      return const SizedBox.shrink();
    }
    final logo = category?.logo;
    final title = category?.name;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomListTile(
          leading: logo != null
              ? CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: CustomNetworkImage(
                    logo,
                    color: Colors.white,
                  ),
                )
              : null,
          title: Text(
            title ?? '',
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          switchValue: switchValue,
          description: 'Gérer vos notifications sur ${title?.toLowerCase()}',
          onChanged: (value) {
            if (notifByCat != null) {
              context.read<NotificationBloc>().add(
                    NotificationValueSwitched(
                      notifByCat!.copyWith(value: value),
                    ),
                  );
            }
          },
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
        const DateInformation(
          label: 'Jour',
          info: 'Lun, Mar, Mer, Jeu, Ven, Sam, Dim',
        ),
        const DateInformation(
          label: 'Heure',
          info: '12:30',
        ),
      ],
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.leading,
    required this.title,
    this.switchValue,
    this.onChanged,
    this.description,
  });

  final Widget? leading;
  final Widget? title;
  final String? description;
  final bool? switchValue;
  final ValueSetter<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: leading,
          title: title,
          trailing: Transform.scale(
            scale: 0.8,
            origin: const Offset(50, 0),
            child: CupertinoSwitch(
              value: switchValue ?? true,
              onChanged: onChanged,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            description ?? '',
          ),
        ),
      ],
    );
  }
}
