part of '../trip_settings_component.dart';

class _TripSettingsTravelMode extends StatelessWidget {
  const _TripSettingsTravelMode();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TripCubit>();
    return BlocSelector<TripCubit, TripState, TripTravelMode>(
      selector: (state) => state.settings.travelMode,
      builder: (context, travelMode) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Travel mode'),
          Row(
            children: [
              _TripSettingsTravelModeChip(
                label: 'Walking',
                travelMode: TripTravelMode.walking,
                selectedTravelMode: travelMode,
                onSelected: cubit.updateTravelMode,
              ),
              const SizedBox(width: 8),
              _TripSettingsTravelModeChip(
                label: 'Bicycling',
                travelMode: TripTravelMode.bicycling,
                selectedTravelMode: travelMode,
                onSelected: cubit.updateTravelMode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
