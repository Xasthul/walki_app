import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';

class TripSettingsContentComponent extends StatelessWidget {
  const TripSettingsContentComponent({
    super.key,
    required VoidCallback collapseSettings,
  }) : _collapseSettings = collapseSettings;

  final VoidCallback _collapseSettings;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<TripCubit>(context);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      FilledButton(
        onPressed: () {
          // TODO(naz): get minutesForTrip from user
          cubit.createTrip(minutesForTrip: 30);
          _collapseSettings();
        },
        child: const Text('Create trip'),
      ),
      FilledButton(
        onPressed: () {
          cubit.clearTrip();
          _collapseSettings();
        },
        child: const Text('Clear trip'),
      ),
    ]);
  }
}
