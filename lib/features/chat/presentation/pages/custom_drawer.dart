import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/custom_button_widget.dart';
import 'package:gpt/features/user/presentation/bloc/auth_bloc/auth_bloc.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';
import '../../../../core/widgets/custom_alert_dialog.dart';
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
      appBar: const CustomAppBar(
        elevation: 0.2,
      ),
      backgroundColor: Colors.transparent,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                          content: const Center(
                            // padding: EdgeInsets.only(top: 20.0),
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Text(
                                'Voulez vraiment vous déconnecter ?',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          actions: [
                            CustomButtonWidget(ButtonType.black).build(
                              context: context,
                              label: 'ok',
                              onPressed: () {
                                context
                                    .read<AuthBloc>()
                                    .add(AuthLogoutSubmitted());
                                context.go(RouteName.home);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    label: 'Se déconnecter',
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
  });

  final String label;
  final Widget icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: TextButton.icon(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: const Color(0xFF4F7CF6).withOpacity(0.08),
              radius: 15,
              child: icon,
            ),
            label: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
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
      const DrawerTile(
        label: 'Mon Profil',
        icon: IconDrawerTiles(
          Icons.person,
        ),
      ),
      const DrawerTile(
        label: 'Nous contacter',
        icon: IconDrawerTiles(
          Icons.mail,
        ),
      ),
      const DrawerTile(
        label: 'Choisir abonnement',
        icon: IconDrawerTiles(
          Icons.favorite,
        ),
      ),
      const DrawerTile(
        label: 'Gérer les notifications',
        icon: IconDrawerTiles(
          Icons.notifications,
        ),
      ),
      DrawerTile(
        label: 'Mode Sombre',
        icon: const IconDrawerTiles(
          Icons.contrast,
        ),
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
                  if (Theme.of(context).brightness == Brightness.dark) {
                    value = false;
                  } else {
                    value = true;
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
      const DrawerTile(
        label: 'Aide',
        icon: IconDrawerTiles(
          Icons.help,
        ),
      ),
      const DrawerTile(
        label: 'A propos',
        icon: IconDrawerTiles(
          Icons.info,
        ),
      ),
      const DrawerTile(
        label: 'Lisez notre CGU',
        icon: IconDrawerTiles(
          Icons.list_alt,
        ),
      ),
      const DrawerTile(
        label: 'Notez l\'application',
        icon: IconDrawerTiles(
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
