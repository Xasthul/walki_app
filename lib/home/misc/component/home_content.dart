part of '../../home_page.dart';

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  static const List<Widget> _pages = [
    TripPage(),
    PlacesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: state.currentIndex,
            children: _pages,
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor: context.homeTheme.bottomNavigationBarSplash,
              highlightColor: context.homeTheme.bottomNavigationBarSplash,
            ),
            child: BottomNavigationBar(
              currentIndex: state.currentIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: 'Trip'),
                BottomNavigationBarItem(icon: Icon(Icons.place_rounded), label: 'Places'),
                BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
              ],
              onTap: context.read<HomeNavigationCubit>().updateCurrentIndex,
              backgroundColor: context.homeTheme.bottomNavigationBarBackground,
              selectedItemColor: context.homeTheme.bottomNavigationBarSelectedIcon,
              elevation: 0,
            ),
          ),
        ),
      );
}
