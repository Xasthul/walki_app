import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/places/cubit/places_cubit.dart';

part 'misc/component/discovered/places_discovered.dart';
part 'misc/component/discovered/places_discovered_tab.dart';
part 'misc/component/discovered/places_in_trip_tab.dart';
part 'misc/component/places_not_discovered.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocBuilder<PlacesCubit, PlacesState>(
            builder: (context, state) => switch (state) {
              PlacesNotDiscovered() => const _PlacesNotDiscovered(),
              PlacesDiscovered() => _PlacesDiscovered(
                  discoveredPlaces: state.discovered,
                  placesInTrip: state.inTrip,
                ),
            },
          ),
        ),
      );
}
