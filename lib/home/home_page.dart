import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/cubit/home_cubit.dart';
import 'package:vall/home/trip/trip_component.dart';
import 'package:vall/home/trip_settings/trip_settings_component.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            if (state is InitialLocationLoaded) {
              return SafeArea(
                top: false,
                child: Stack(children: [
                  TripComponent(initialLocation: state.location),
                  const TripSettingsComponent(),
                ]),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
        ),
      );
}
