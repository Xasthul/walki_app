import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/widget/app_loading_cover.dart';
import 'package:vall/app/common/widget/app_loading_indicator.dart';
import 'package:vall/home/trip/cubit/current_location/current_location_cubit.dart';
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
            child: BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
              buildWhen: (previous, current) => previous is CurrentLocationLoading && current is CurrentLocationUpdated,
              builder: (context, currentLocationState) {
                if (currentLocationState is CurrentLocationLoading) {
                  return const Center(child: AppLoadingIndicator());
                }
                final initialLocation = (currentLocationState as CurrentLocationUpdated).location;
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
