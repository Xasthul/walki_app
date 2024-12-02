part of 'trip_settings_component.dart';

class _TripSettingsYourTrip extends StatelessWidget {
  const _TripSettingsYourTrip({
    required VoidCallback collapseSettings,
  }) : _collapseSettings = collapseSettings;

  final VoidCallback _collapseSettings;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TripCubit>();
    return BlocSelector<TripCubit, TripState, TripPlaces>(
      selector: (state) => state.tripPlaces,
      builder: (context, tripPlaces) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your trip'),
          const SizedBox(height: 4),
          Row(children: [
            AppFilledButton(
              onPressed: tripPlaces.isEmpty
                  ? null
                  : () {
                      cubit.createTrip();
                      _collapseSettings();
                    },
              label: 'Create',
            ),
            const SizedBox(width: 8),
            AppFilledButton(
              onPressed: tripPlaces.isEmpty ? null : cubit.clearTrip,
              label: 'Clear',
            ),
          ]),
        ],
      ),
    );
  }
}
