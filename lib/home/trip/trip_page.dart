import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/app/common/component/app_loading_indicator.dart';
import 'package:vall/home/trip/cubit/initial_location/initial_location_cubit.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';
import 'package:vall/home/trip/misc/component/trip_map_component.dart';
import 'package:vall/home/trip/misc/component/trip_settings/trip_settings_component.dart';

class TripPage extends StatelessWidget {
  const TripPage({super.key});

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: SafeArea(
            top: false,
            child: BlocSelector<InitialLocationCubit, InitialLocationState, LatLng?>(
              selector: (state) => state is InitialLocationLoaded ? state.location : null,
              builder: (context, initialLocation) {
                if (initialLocation == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return BlocBuilder<TripCubit, TripState>(
                  builder: (context, state) => Stack(children: [
                    TripMapComponent(initialLocation: initialLocation),
                    const TripSettingsComponent(),
                    if (state is TripLoading) const AppLoadingIndicator(),
                  ]),
                );
              },
            ),
          ),
        ),
      );
}
