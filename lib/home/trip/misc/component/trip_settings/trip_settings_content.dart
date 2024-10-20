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
        FilledButton(
          onPressed: cubit.findPlaces,
          child: const Text('Find places nearby'),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          FilledButton(
            onPressed: state.selectedPlaces.isEmpty
                ? null
                : () {
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
      ]),
    );
  }
}
