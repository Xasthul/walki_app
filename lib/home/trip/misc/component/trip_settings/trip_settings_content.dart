part of 'trip_settings_component.dart';

class _TripSettingsContent extends StatelessWidget {
  const _TripSettingsContent({
    required VoidCallback collapseSettings,
  }) : _collapseSettings = collapseSettings;

  final VoidCallback _collapseSettings;

  static const double _minSearchRadius = 500;
  static const double _maxSearchRadius = 2500;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TripCubit>();
    return BlocBuilder<TripCubit, TripState>(builder: (context, state) {
      return Column(children: [
        Slider(
          value: state.settings.searchRadius,
          min: _minSearchRadius,
          max: _maxSearchRadius,
          onChanged: cubit.updateSearchRadius,
        ),
        FilledButton(
          onPressed: cubit.findPlaces,
          child: const Text('Find places nearby'),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          FilledButton(
            onPressed: () {
              cubit.createTrip();
              _collapseSettings();
            },
            child: const Text('Create trip'),
          ),
          FilledButton(
            onPressed: cubit.clearTrip,
            child: const Text('Clear trip'),
          ),
        ]),
      ]);
    });
  }
}
