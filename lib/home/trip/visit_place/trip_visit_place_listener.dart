import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';
import 'package:vall/home/trip/visit_place/cubit/trip_visit_place_cubit.dart';

part 'misc/widget/trip_visit_place_reached_dialog.dart';

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
        tripVisitPlaceCubit.onTripCreated(places: state.tripPlaces.discoveredPlaces);
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
              return _showPlaceReachedDialog(context, state.place);
            }
          },
          child: _child,
        ),
      ),
    );
  }

  void _showPlaceReachedDialog(BuildContext context, PointOfInterest place) => showDialog(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (context) => _TripVisitPlaceReachedDialog(place: place),
      );
}
