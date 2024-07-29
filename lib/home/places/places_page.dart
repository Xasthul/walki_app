import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vall/home/places/cubit/places_cubit.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocBuilder<PlacesCubit, PlacesState>(
            builder: (context, state) => switch (state) {
              PlacesNoTripCreated() => const _PlacesNoTripCreatedComponent(),
              PlacesTripCreated() => const Center(child: Text('The trip is created'))
            },
          ),
        ),
      );
}

class _PlacesNoTripCreatedComponent extends StatelessWidget {
  const _PlacesNoTripCreatedComponent();

  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('No trip created yet'),
          const SizedBox(height: 24),
          FilledButton(
            // TODO(naz): use types routes
            onPressed: () => context.go('/trip'),
            child: const Text('Go to trip creation'),
          ),
        ]),
      );
}
