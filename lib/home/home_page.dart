import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/cubit/home_cubit.dart';
import 'package:vall/home/trip/trip_component.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            if (state is GetLocationPermissionSuccess) {
              return const TripComponent();
            }
            return const Center(child: CircularProgressIndicator());
          }),
        ),
      );
}
