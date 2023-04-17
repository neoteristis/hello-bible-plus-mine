import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
          child: Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hello',
                    style: TextStyle(color: Colors.brown[400], fontSize: 40),
                  ),
                  TextSpan(
                    text: 'Bible',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[900],
                        fontSize: 40),
                  ),
                ],
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return const ListTile(
              title: Text('Que dit la Bible ?'),
            );
          },
        )
      ]),
    );
  }
}
