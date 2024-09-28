part of '../../home_page.dart';

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required StatefulNavigationShell navigationShell,
  }) : _navigationShell = navigationShell;

  final StatefulNavigationShell _navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
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
