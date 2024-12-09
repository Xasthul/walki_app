import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/misc/navigator/home_navigator.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';
import 'package:vall/home/trip/visit_place/cubit/trip_visit_place_cubit.dart';

class TripVisitPlaceListener extends StatelessWidget {
  const TripVisitPlaceListener({
    super.key,
    required Widget child,
  }) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) {
    final tripVisitPlaceCubit = context.read<TripVisitPlaceCubit>();
    // initiate checking for places nearby
    return BlocListener<TripCubit, TripState>(
      listenWhen: (previousState, newState) => previousState is! TripCreated && newState is TripCreated,
      listener: (context, state) {
        tripVisitPlaceCubit.onTripCreated(places: state.tripPlaces);
      },
      // stop checking for places nearby
      child: BlocListener<TripCubit, TripState>(
        listenWhen: (previousState, newState) => previousState is TripCreated && newState is! TripCreated,
        listener: (context, state) {
          tripVisitPlaceCubit.onTripFinished();
        },
        child: BlocListener<TripVisitPlaceCubit, TripVisitPlaceState>(
          listener: (context, state) {
            if (state is TripVisitPlaceReached) {
              HomeNavigator.of(context).showTripVisitPlaceDialog(place: state.place);
            }
          },
          child: _child,
        ),
      ),
    );
  }
}
