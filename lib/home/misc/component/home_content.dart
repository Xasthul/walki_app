part of '../../home_page.dart';

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  static const List<Widget> _pages = [
    TripPage(),
    PlacesPage(),
  ];

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
        builder: (context, state) {
          final currentIndex = state.currentIndex;
          return Scaffold(
            backgroundColor: Colors.white,
            body: _pages[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: 'Trip'),
                BottomNavigationBarItem(icon: Icon(Icons.place_rounded), label: 'Places'),
              ],
              onTap: context.read<HomeNavigationCubit>().updateCurrentIndex,
            ),
          );
        },
      );
}
