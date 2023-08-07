import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: showBottomNavigation(context)
            ? BottomNavigationBar(
                currentIndex: navigationShell.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Accueil',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    label: 'Découvrir',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history_sharp),
                    label: 'Historique',
                  ),
                ],
                onTap: _onTap,
              )
            : null,
      ),
      onWillPop: () async => canWillPop(context),
    );
  }

  void _onTap(index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  bool canWillPop(BuildContext context) {
    final path = GoRouterState.of(context).fullPath;
    if (path == null) {
      return false;
    }
    if (countCharacterForString(path, '/') > 1) {
      return true;
    }
    return false;
  }

  bool showBottomNavigation(BuildContext context) {
    final path = GoRouterState.of(context).fullPath;
    if (countCharacterForString(path!, '/') > 1) {
      return false;
    } else {
      return true;
    }
  }

  int countCharacterForString(String str, String char) {
    int count = 0;
    for (int i = 0; i < str.length; i++) {
      if (str[i] == char) {
        count++;
      }
    }
    return count;
  }
}
