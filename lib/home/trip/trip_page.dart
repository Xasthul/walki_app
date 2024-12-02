import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/app/common/widget/app_loading_cover.dart';
import 'package:vall/app/common/widget/app_loading_indicator.dart';
import 'package:vall/home/trip/cubit/initial_location/initial_location_cubit.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';
import 'package:vall/home/trip/misc/widget/trip_map/trip_map_component.dart';
import 'package:vall/home/trip/misc/widget/trip_settings/trip_settings_component.dart';
import 'package:vall/home/trip/visit_place/trip_visit_place_listener.dart';

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
                  return const Center(child: AppLoadingIndicator());
                }
                return TripVisitPlaceListener(
                  child: BlocBuilder<TripCubit, TripState>(
                    builder: (context, state) => Stack(children: [
                      TripMapComponent(initialLocation: initialLocation),
                      if (state is! TripPlaceSelection) const TripSettingsComponent(),
                      if (state is TripLoading) const AppLoadingCover(),
                    ]),
                  ),
                );
              },
            ),
          ),
        ),
      );
}
