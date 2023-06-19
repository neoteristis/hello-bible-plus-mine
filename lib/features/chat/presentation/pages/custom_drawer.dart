import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/categories_widget.dart';
import '../widgets/custom_app_bar.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            decoration: const BoxDecoration(color: Colors.white),
            width: MediaQuery.of(context).size.width * 0.85,
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
  });

  final String label;
  final Widget icon;

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
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

const drawerTiles = [
  DrawerTile(
    label: 'Mon Profil',
    icon: Icon(
      Icons.person,
      size: 20,
      color: Colors.black,
    ),
  ),
  DrawerTile(
    label: 'Nous contacter',
    icon: Icon(
      Icons.mail,
      size: 20,
      color: Colors.black,
    ),
  ),
  DrawerTile(
    label: 'Choisir abonnement',
    icon: Icon(
      Icons.favorite,
      size: 20,
      color: Colors.black,
    ),
  ),
  DrawerTile(
    label: 'Gérer les notifications',
    icon: Icon(
      Icons.notifications,
      size: 20,
      color: Colors.black,
    ),
  ),
  DrawerTile(
    label: 'Aide',
    icon: Icon(
      Icons.help,
      size: 20,
      color: Colors.black,
    ),
  ),
  DrawerTile(
    label: 'A propos',
    icon: Icon(
      Icons.info,
      size: 20,
      color: Colors.black,
    ),
  ),
  DrawerTile(
    label: 'Lisez notre CGU',
    icon: Icon(
      Icons.list_alt,
      size: 20,
      color: Colors.black,
    ),
  ),
  DrawerTile(
    label: 'Notez l\'application',
    icon: Icon(
      Icons.star,
      size: 20,
      color: Colors.black,
    ),
  ),
];
