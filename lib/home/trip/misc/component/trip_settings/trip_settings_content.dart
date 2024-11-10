part of 'trip_settings_component.dart';

class _TripSettingsContent extends StatelessWidget {
  const _TripSettingsContent({
    required VoidCallback collapseSettings,
  }) : _collapseSettings = collapseSettings;

  final VoidCallback _collapseSettings;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TripCubit>();
    return BlocBuilder<TripCubit, TripState>(
      builder: (context, state) => Column(children: [
        const _TripSettingsSearchRadius(),
        const _TripSettingsTravelMode(),
        FilledButton(
          onPressed: cubit.findPlaces,
          child: const Text('Find places nearby'),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          FilledButton(
            onPressed: state.tripPlaces.isEmpty
                ? null
                : () {
                    cubit.createTrip();
                    _collapseSettings();
                  },
            child: const Text('Create trip'),
          ),
          FilledButton(
            onPressed: state.tripPlaces.isEmpty ? null : cubit.clearTrip,
            child: const Text('Clear trip'),
          ),
        ]),
        FilledButton(
          onPressed: state.foundPlaces.places.isEmpty ? null : cubit.startPlaceSelection,
          child: const Text('Select place'),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          FilledButton(
            onPressed: state.foundPlaces.places.isEmpty ? null : cubit.findRestaurants,
            child: const Text('Find restaurants'),
          ),
          FilledButton(
            onPressed: state.foundPlaces.places.isEmpty ? null : cubit.findCafes,
            child: const Text('Find cafes'),
          ),
        ]),
      ]),
    );
  }
}
