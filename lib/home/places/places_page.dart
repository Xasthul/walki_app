import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vall/home/places/cubit/places_cubit.dart';
import 'package:vall/home/trip/misc/entity/point_of_interest.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocBuilder<PlacesCubit, PlacesState>(
            builder: (context, state) => switch (state) {
              PlacesNotDiscovered() => const _PlacesNotDiscoveredComponent(),
              PlacesDiscovered() => _PlacesDiscoveredComponent(places: state.places),
            },
          ),
        ),
      );
}

class _PlacesNotDiscoveredComponent extends StatelessWidget {
  const _PlacesNotDiscoveredComponent();

  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('No places found yet'),
          const SizedBox(height: 24),
          FilledButton(
            // TODO(naz): use types routes
            onPressed: () => context.go('/trip'),
            child: const Text('Go to places discovery'),
          ),
        ]),
      );
}

class _PlacesDiscoveredComponent extends StatelessWidget {
  const _PlacesDiscoveredComponent({
    required List<PointOfInterest> places,
  }) : _places = places;

  final List<PointOfInterest> _places;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PlacesCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: _places.length,
        itemBuilder: (context, index) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(_places[index].name),
          TextButton(
            onPressed: () => cubit.addPlaceToTrip(_places[index]),
            child: const Text('Add to trip'),
          ),
        ]),
      ),
    );
  }
}
