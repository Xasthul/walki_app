part of 'trip_settings_component.dart';

class _TripSettingsFindPlaces extends StatelessWidget {
  const _TripSettingsFindPlaces();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TripCubit>();
    return BlocSelector<TripCubit, TripState, FoundPlaces>(
      selector: (state) => state.foundPlaces,
      builder: (context, foundPlaces) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Find places'),
          const SizedBox(height: 4),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AppFilledButton(
                  onPressed: cubit.findPlaces,
                  label: 'Touristic attractions',
                ),
                const SizedBox(width: 8),
                AppFilledButton(
                  onPressed: foundPlaces.places.isEmpty ? null : cubit.findRestaurants,
                  label: 'Restaurants',
                ),
                const SizedBox(width: 8),
                AppFilledButton(
                  onPressed: foundPlaces.places.isEmpty ? null : cubit.findCafes,
                  label: 'Cafes',
                ),
                const SizedBox(width: 8),
                AppFilledButton(
                  onPressed: foundPlaces.places.isEmpty ? null : cubit.startPlaceSelection,
                  label: 'Choose on map',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
