import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vall/home/cubit/location_permission/location_permission_cubit.dart';
import 'package:vall/home/home_dependencies.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required StatefulNavigationShell navigationShell,
  }) : _navigationShell = navigationShell;

  final StatefulNavigationShell _navigationShell;

  @override
  Widget build(BuildContext context) => HomeDependencies(
        child: BlocBuilder<LocationPermissionCubit, LocationPermissionState>(
          builder: (context, state) {
            if (state is! LocationPermissionProvided) {
              return const _HomeLoadingContentComponent();
            }
            return _HomeContentComponent(navigationShell: _navigationShell);
          },
        ),
      );
}

class _HomeContentComponent extends StatelessWidget {
  const _HomeContentComponent({
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

class _HomeLoadingContentComponent extends StatelessWidget {
  const _HomeLoadingContentComponent();

  @override
  Widget build(BuildContext context) => const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
}
