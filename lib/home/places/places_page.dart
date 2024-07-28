import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/places/cubit/places_cubit.dart';
import 'package:vall/home/places/places_dependencies.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({super.key});

  @override
  Widget build(BuildContext context) => PlacesDependencies(
        child: Scaffold(
          body: SafeArea(
            child: BlocBuilder<PlacesCubit, PlacesState>(builder: (context, state) {
              return switch (state) {
                PlacesNoTripCreated() => const Center(child: Text('No trip created yet')),
                PlacesTripCreated() => const Center(child: Text('The trip is created'))
              };
            }),
          ),
        ),
      );
}
