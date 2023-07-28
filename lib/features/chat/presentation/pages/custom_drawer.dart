import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/custom_button_widget.dart';
import 'package:gpt/features/user/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';
import '../../../../core/widgets/custom_alert_dialog.dart';
import '../../../../l10n/function.dart';
import '../bloc/chat_bloc/chat_bloc.dart';
import '../bloc/historical_bloc/historical_bloc.dart';
import '../widgets/categories_widget.dart';
import '../widgets/custom_app_bar.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final drawerTiles = getDrawerTiles(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context
                    .read<ChatBloc>()
                    .scaffoldKey
                    .currentState
                    ?.closeEndDrawer();
              },
            ),
          ),
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      if (index == 0) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            drawerTiles[index],
                          ],
                        );
                      }
                      return drawerTiles[index];
                    },
                    separatorBuilder: (ctx, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        child: CustomDivider(),
                      );
                    },
                    itemCount: drawerTiles.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                    bottom: 25,
                    top: 5,
                  ),
                  child: CustomButtonWidget(ButtonType.black).build(
                    context: context,
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => CustomAlertDialog(
                          height: 100,
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(5)),
                          content: Center(
                            // padding: EdgeInsets.only(top: 20.0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .askConfirmationLogout,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          actions: [
                            CustomButtonWidget(ButtonType.black).build(
                              context: context,
                              label: AppLocalizations.of(context)!.ok,
                              onPressed: () {
                                context
                                  ..read<AuthBloc>().add(AuthLogoutSubmitted())
                                  ..read<HistoricalBloc>()
                                      .add(HistoricalCleared())
                                  ..go(RouteName.home);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    label: AppLocalizations.of(context)!.logout,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.label,
    required this.icon,
    this.trailing,
    this.onPressed,
  });

  final String label;
  final Widget icon;
  final Widget? trailing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: TextButton.icon(
            onPressed: onPressed,
            icon: CircleAvatar(
              backgroundColor: const Color(0xFF4F7CF6).withOpacity(0.08),
              radius: 15,
              child: icon,
            ),
            label: Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(),
            ),
          ),
        ),
        if (trailing != null) const Spacer(),
        if (trailing != null) trailing!,
      ],
    );
  }
}

List<Widget> getDrawerTiles(BuildContext context) => [
      DrawerTile(
        label: dict(context).myProfile,
        icon: const IconDrawerFromAsset('assets/icons/profil.svg'),
        onPressed: () {
          context.go(RouteName.profile);
        },
      ),
      DrawerTile(
        label: dict(context).mySubscription,
        icon: const IconDrawerFromAsset('assets/icons/subscription.svg'),
        onPressed: () {
          context.go(RouteName.subscribe);
        },
      ),
      DrawerTile(
        label: dict(context).myHistory,
        icon: const IconDrawerTiles(
          Icons.history,
        ),
        onPressed: () {
          context.read<ChatBloc>().scaffoldKey.currentState?.closeEndDrawer();
          context.go(RouteName.historical);
        },
      ),
      DrawerTile(
        label: dict(context).manageNotifications,
        icon: const IconDrawerTiles(
          Icons.notifications,
        ),
        onPressed: () {
          context.go(RouteName.manageNotif);
        },
      ),
      DrawerTile(
        label: AppLocalizations.of(context)!.darkMode,
        icon: const IconDrawerFromAsset('assets/icons/brightness.svg'),
        trailing: Transform.scale(
          scale: 0.8,
          child: BlocBuilder<ThemeBloc, ThemeState>(
            buildWhen: (previous, current) =>
                previous.themeMode != current.themeMode,
            builder: (context, state) {
              bool? value;
              switch (state.themeMode) {
                case ThemeMode.dark:
                  value = true;
                  break;
                case ThemeMode.light:
                  value = false;
                  break;
                default:
                  if (Theme.of(context).colorScheme.brightness ==
                      Brightness.dark) {
                    value = true;
                  } else {
                    value = false;
                  }
              }
              return CupertinoSwitch(
                value: value,
                onChanged: (_) {
                  context.read<ThemeBloc>().add(ThemeChanged(context));
                },
              );
            },
          ),
        ),
      ),
      DrawerTile(
        label: dict(context).contactUs,
        icon: const IconDrawerTiles(
          Icons.mail,
        ),
        onPressed: () {
          context.go(RouteName.contactUs);
        },
      ),
      DrawerTile(
        label: dict(context).help,
        icon: const IconDrawerTiles(
          Icons.help,
        ),
        onPressed: () {
          context.go(RouteName.help);
        },
      ),
      DrawerTile(
        label: dict(context).about,
        icon: const IconDrawerTiles(
          Icons.info,
        ),
        onPressed: () {
          context.go(RouteName.about);
        },
      ),
      DrawerTile(
        label: dict(context).readOurConditions,
        icon: const IconDrawerFromAsset('assets/icons/cgu.svg'),
        onPressed: () {
          context.go(RouteName.conditions);
        },
      ),
      DrawerTile(
        label: dict(context).rateApp,
        icon: const IconDrawerTiles(
          Icons.star,
        ),
      ),
    ];

class IconDrawerTiles extends StatelessWidget {
  const IconDrawerTiles(
    this.icon, {
    super.key,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 20,
      color: Theme.of(context).colorScheme.tertiary,
    );
  }
}

class IconDrawerFromAsset extends StatelessWidget {
  const IconDrawerFromAsset(
    this.path, {
    super.key,
  });

  final String path;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      color: Theme.of(context).colorScheme.tertiary,
    );
  }
}
