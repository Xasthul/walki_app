import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vall/app/routes/app_routes.dart';
import 'package:vall/home/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        // TODO(naz): use themes
        backgroundColor: Colors.white,
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is GetLocationPermissionSuccess) {
              // TODO(naz): use type routes
              return context.go(PageName.tripPagePath);
            }
          },
          builder: (context, state) => const Center(child: CircularProgressIndicator()),
        ),
      );
}
