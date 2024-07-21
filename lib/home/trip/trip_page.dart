import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/trip/common/component/trip_map_component.dart';
import 'package:vall/home/trip/common/component/trip_settings_component.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';

class TripPage extends StatelessWidget {
  const TripPage({super.key});

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: SafeArea(
            top: false,
            child: BlocBuilder<TripCubit, TripState>(builder: (context, state) {
              if (state is TripInitialLocationLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Stack(children: [
                const TripMapComponent(),
                const TripSettingsComponent(),
                if (state is TripLoading)
                  AbsorbPointer(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white.withOpacity(0.6),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
              ]);
            }),
          ),
        ),
      );
}