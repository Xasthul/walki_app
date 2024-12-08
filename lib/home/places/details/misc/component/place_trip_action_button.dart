part of '../../place_details_page.dart';

class _PlaceTripActionButton extends StatelessWidget {
  const _PlaceTripActionButton({
    required GooglePlace place,
  }) : _place = place;

  final GooglePlace _place;

  @override
  Widget build(BuildContext context) => BlocSelector<PlacesCubit, PlacesState, List<Place>>(
        selector: (state) => state is PlacesDiscovered ? state.inTrip : [],
        builder: (context, placesInTrip) => Center(
          child: AppFilledButton(
            onPressed: () => context.read<PlacesCubit>().togglePlace(_place),
            label: placesInTrip.contains(_place) //
                ? 'Remove from the trip'
                : 'Add to the trip',
          ),
        ),
      );
}
