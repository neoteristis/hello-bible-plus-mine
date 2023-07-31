import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/custom_drawer.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: navigationShell,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Section',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_sharp),
                label: 'History',
              ),
            ],
            onTap: _onTap,
          ),
        ),
        onWillPop: () async => false);
  }

  void _onTap(index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
