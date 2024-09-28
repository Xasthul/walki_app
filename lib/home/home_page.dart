import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vall/home/cubit/location_permission/location_permission_cubit.dart';
import 'package:vall/home/home_dependencies.dart';

part 'misc/component/home_content.dart';
part 'misc/component/home_loading_content.dart';

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
              return const _HomeLoadingContent();
            }
            return _HomeContent(navigationShell: _navigationShell);
          },
        ),
      );
}
