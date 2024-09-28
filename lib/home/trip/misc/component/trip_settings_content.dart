part of 'trip_settings_component.dart';

class _TripSettingsContent extends StatelessWidget {
  const _TripSettingsContent({
    required VoidCallback collapseSettings,
  }) : _collapseSettings = collapseSettings;

  final VoidCallback _collapseSettings;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TripCubit>();
    return Column(children: [
      FilledButton(
        onPressed: cubit.findPlaces,
        child: const Text('Find places nearby'),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        FilledButton(
          onPressed: () {
            // TODO(naz): get minutesForTrip from user
            cubit.createTrip(minutesForTrip: 30);
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
  }
}
