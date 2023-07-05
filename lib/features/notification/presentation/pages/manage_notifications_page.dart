import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/helper/show_dialog.dart';
import 'package:gpt/core/widgets/scaffold_with_background.dart';
import 'package:gpt/features/chat/presentation/widgets/categories_widget.dart';
import '../../../../core/constants/status.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageNotifBloc, ManageNotifState>(
      listenWhen: (previous, current) =>
          previous.configureNotifStatus != current.configureNotifStatus,
      listener: (context, state) async {
        switch (state.configureNotifStatus) {
          case Status.loaded:
            await CustomDialog.success(
              context,
              dict(context).changeNotSupported,
            );
            break;
          case Status.failed:
            await CustomDialog.error(
              context,
              dict(context).modificationTakenIntoAccount,
            );
            break;
          default:
        }
      },
      child: ScaffoldWithBackground(
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
            },
          ),
        ),
      ),
    );
  }
}
