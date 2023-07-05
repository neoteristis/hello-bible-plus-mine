import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/scaffold_with_background.dart';
import 'package:gpt/features/chat/presentation/widgets/categories_widget.dart';
import '../../../../core/extension/time_of_day_extension.dart';
import '../../../../l10n/function.dart';
import '../bloc/manage_notif/manage_notif_bloc.dart';
import '../widgets/notif_manage_item_widget.dart';

class ManageNotificationsPage extends StatefulWidget {
  const ManageNotificationsPage({super.key});

  @override
  State<ManageNotificationsPage> createState() =>
      _ManageNotificationsPageState();
}

class _ManageNotificationsPageState extends State<ManageNotificationsPage> {
  @override
  void initState() {
    super.initState();
    // context.read<NotificationBloc>().add(NotificationValuesByCategoryGotten());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      addBackgroundImage: false,
      onPop: () {
        context.pop();
      },
      title: dict(context).manageNotifications,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15,
          // top: 20,
        ),
        child: BlocBuilder<ManageNotifBloc, ManageNotifState>(
          buildWhen: (previous, current) =>
              previous.notifByCategory != current.notifByCategory,
          builder: (context, state) {
            final notifByCategory = state.notifByCategory;
            return ListView.separated(
              itemBuilder: (context, index) => NotifManageItem(
                notifByCategory[index],
                onTap: () {
                  context.read<ManageNotifBloc>().add(
                        ManageNotifTimeChanged(
                          context: context,
                          id: notifByCategory[index].id!,
                        ),
                      );
                },
              ),
              separatorBuilder: (context, index) => const CustomDivider(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
              ),
              itemCount: notifByCategory!.length,
            );
            // return Column(
            //   children: [
            //     ...notifByCategory!.map((e) => ,);
            //     NotifManageItem(
            //       switchValue: true,
            //       logo: const Icon(
            //         Icons.book,
            //         color: Colors.white,
            //       ),
            //       title: dict(context).verseOfTheDay,
            //       hour: '08:00',
            //     ),
            //     const CustomDivider(
            //       padding: EdgeInsets.symmetric(
            //         vertical: 8.0,
            //       ),
            //     ),
            //     NotifManageItem(
            //       switchValue: true,
            //       logo: const Icon(
            //         Icons.favorite,
            //         color: Colors.white,
            //       ),
            //       title: dict(context).wordOfEncouragement,
            //       hour: '10:00',
            //     ),
            //   ],
            // );
          },
        ),
      ),
    );

    // return ScaffoldWithBackground(
    //   addBackgroundImage: false,
    //   onPop: () {
    //     context.pop();
    //   },
    //   title: 'Gérer les notifications',
    //   body: BlocBuilder<NotificationBloc, NotificationState>(
    //     // buildWhen: (previous, current) => previous.status != current.status,
    //     builder: (context, state) {
    //       switch (state.status) {
    //         case Status.loading:
    //           return const Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         case Status.loaded:
    //           final notifCats = state.notifCats;
    //           if (notifCats == null) {
    //             return const Center(
    //               child: Text('Empty'),
    //             );
    //           }
    //           return Padding(
    //             padding: const EdgeInsets.only(
    //               left: 15.0,
    //               right: 15,
    //               // top: 20,
    //             ),
    //             child: BlocBuilder<NotificationBloc, NotificationState>(
    //               // buildWhen: (previous, current) =>
    //               //     previous.notifCats != current.notifCats,
    //               builder: (context, state) {
    //                 return ListView.separated(
    //                   itemCount: notifCats.length,
    //                   separatorBuilder: (context, index) => const CustomDivider(
    //                     padding: EdgeInsets.symmetric(
    //                       vertical: 8.0,
    //                     ),
    //                   ),
    //                   itemBuilder: (context, index) {
    //                     final notif = notifCats[index];
    //                     final category = notif.category;
    //                     final value = notif.value;
    //                     if (index == 0) {
    //                       return Column(
    //                         children: [
    //                           CustomListTile(
    //                             leading: CircleAvatar(
    //                               backgroundColor:
    //                                   Theme.of(context).primaryColor,
    //                               child: const Icon(Icons.android),
    //                             ),
    //                             title: Text(
    //                               'A propos de l\'application',
    //                               style: TextStyle(
    //                                 color:
    //                                     Theme.of(context).colorScheme.tertiary,
    //                                 fontWeight: FontWeight.w600,
    //                                 fontSize: 16,
    //                               ),
    //                             ),
    //                             description:
    //                                 'Message de la part des développeurs et les notifications liées à l\'application comme les mise à jour',
    //                             onChanged: (_) {},
    //                           ),
    //                           const CustomDivider(
    //                             padding: EdgeInsets.symmetric(
    //                               vertical: 8.0,
    //                             ),
    //                           ),
    //                           CategoryNotifManageItem(
    //                             category,
    //                             switchValue: value!,
    //                             notifByCat: notif,
    //                           ),
    //                         ],
    //                       );
    //                     }
    //                     return CategoryNotifManageItem(
    //                       category,
    //                       switchValue: value!,
    //                       notifByCat: notif,
    //                     );
    //                   },
    //                 );
    //               },
    //             ),
    //           );
    //         default:
    //           return const SizedBox.shrink();
    //       }
    //     },
    //   ),
    // );
  }
}
