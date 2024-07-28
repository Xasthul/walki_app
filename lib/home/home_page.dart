import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vall/home/cubit/home_cubit.dart';
import 'package:vall/home/home_dependencies.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => HomeDependencies(
        child: Scaffold(
          // TODO(naz): use themes
          backgroundColor: Colors.white,
          body: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeGetLocationPermissionSuccess) {
                // TODO(naz): use type routes
                return context.go('/home/trip');
              }
            },
            builder: (context, state) => const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
}
