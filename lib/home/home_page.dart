import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/theme/home_theme.dart';
import 'package:vall/app/common/widget/app_loading_page.dart';
import 'package:vall/home/cubit/home_navigation/home_navigation_cubit.dart';
import 'package:vall/home/cubit/location_permission/location_permission_cubit.dart';
import 'package:vall/home/home_dependencies.dart';
import 'package:vall/home/misc/navigator/home_navigator.dart';
import 'package:vall/home/places/places_page.dart';
import 'package:vall/home/profile/profile_page.dart';
import 'package:vall/home/trip/trip_page.dart';

part 'misc/component/home_content.dart';

final _navigationKey = GlobalKey<NavigatorState>();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => HomeDependencies(
        child: HomeNavigator(
          navigationKey: _navigationKey,
          child: BlocBuilder<LocationPermissionCubit, LocationPermissionState>(
            builder: (context, state) {
              if (state is! LocationPermissionProvided) {
                return const AppLoadingPage();
              }
              return const _HomeContent();
            },
          ),
        ),
      );
}
