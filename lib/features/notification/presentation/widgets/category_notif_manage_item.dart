import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gpt/features/notification/presentation/bloc/notification_bloc.dart';

import '../../../../core/widgets/custom_bubble.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../chat/domain/entities/category.dart';
import '../../domain/entities/notif_by_category.dart';
import 'custom_list_tile.dart';
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
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                contentPadding: EdgeInsets.zero,
                content: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? const Color(0xFFF3F5F7)
                        : null,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Choisissez les jours',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3,
                                    crossAxisSpacing: 50,
                                    mainAxisSpacing: 0,
                                  ),
                                  itemBuilder: (BuildContext ctx, index) {
                                    return DayChoice(
                                      day: Day(
                                        name: days[index],
                                        id: index,
                                      ),
                                      value: false,
                                    );
                                  },
                                  itemCount: days.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _ActionButton(
                              label: 'Annuler',
                              nip: BubbleNip.leftBottom,
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            child: _ActionButton(
                              label: 'OK',
                              nip: BubbleNip.rightBottom,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          child: const DateInformation(
            label: 'Jour',
            info: 'Lun, Mar, Mer, Jeu, Ven, Sam, Dim',
          ),
        ),
        const DateInformation(
          label: 'Heure',
          info: '12:30',
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.onTap,
    required this.label,
    required this.nip,
  });

  final VoidCallback onTap;
  final String label;
  final BubbleNip nip;

  @override
  Widget build(BuildContext context) {
    final borderRadius = nip == BubbleNip.leftBottom
        ? const BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
            bottomLeft: Radius.circular(5),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(4),
            bottomLeft: Radius.circular(0),
          );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: Theme.of(context).dividerTheme.color!),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class DayChoice extends StatelessWidget {
  const DayChoice({
    super.key,
    required this.day,
    required this.value,
  });

  final Day day;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          day.name,
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const Spacer(),
        Transform.scale(
          scale: 0.8,
          origin: const Offset(50, 0),
          child: CupertinoSwitch(
            value: value,
            onChanged: (_) {},
          ),
        ),
      ],
    );
  }
}

class Day extends Equatable {
  final int? id;
  final String name;
  const Day({
    this.id,
    required this.name,
  });
  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

List<String> days = [
  'Lundi',
  'Mardi',
  'Mercredi',
  'Jeudi',
  'Vendredi',
  'Samedi',
  'Dimanche',
];
