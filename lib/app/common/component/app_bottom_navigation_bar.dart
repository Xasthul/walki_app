import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required StatefulNavigationShell navigationShell,
  }) : _navigationShell = navigationShell;

  final StatefulNavigationShell _navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _navigationShell.currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: 'Trip'),
            BottomNavigationBarItem(icon: Icon(Icons.place_rounded), label: 'Places'),
          ],
          onTap: (index) => _navigationShell.goBranch(
            index,
            initialLocation: index == _navigationShell.currentIndex,
          ),
        ),
      );
}
