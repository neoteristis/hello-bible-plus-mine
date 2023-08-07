import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/helper/show_dialog.dart';
import 'package:gpt/core/widgets/custom_progress_indicator.dart';
import 'package:gpt/core/widgets/scaffold_with_background.dart';
import 'package:gpt/features/chat/presentation/widgets/categories_widget.dart';
import '../../../../core/constants/status.dart';
import '../../../../l10n/function.dart';
import '../../../container/pages/section/presentation/pages/section_page.dart';
import '../bloc/manage_notif/manage_notif_bloc.dart';
import '../widgets/notif_manage_item_widget.dart';

class ManageNotificationsPage extends StatefulWidget {
  static const String route = 'manage-notification-page';
  const ManageNotificationsPage({super.key});

  @override
  State<ManageNotificationsPage> createState() =>
      _ManageNotificationsPageState();
}

class _ManageNotificationsPageState extends State<ManageNotificationsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ManageNotifBloc>().add(ManageNotifCategoryFetched());
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
              dict(context).modificationTakenIntoAccount,
            );
            break;
          case Status.failed:
            await CustomDialog.error(
              context,
              dict(context).changeNotSupported,
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
        body: BlocBuilder<ManageNotifBloc, ManageNotifState>(
          buildWhen: (previous, current) =>
              previous.notifCategoryStatus != current.notifCategoryStatus,
          builder: (context, state) {
            switch (state.notifCategoryStatus) {
              case Status.loading:
                return const Center(
                  child: CustomProgressIndicator(),
                );
              case Status.failed:
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      context.read<ManageNotifBloc>().add(
                            ManageNotifCategoryFetched(),
                          );
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Rafraichir'),
                        Icon(
                          Icons.refresh_rounded,
                          // size: 50,
                        ),
                      ],
                    ),
                  ),
                );
              case Status.loaded:
                return Padding(
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
                      if (notifByCategory != null && notifByCategory.isEmpty) {
                        return const Center(
                          child: Text('Aucune notification configurée'),
                        );
                      }
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
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
                        separatorBuilder: (context, index) =>
                            const CustomDivider(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                        ),
                        itemCount: notifByCategory!.length,
                      );
                    },
                  ),
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
