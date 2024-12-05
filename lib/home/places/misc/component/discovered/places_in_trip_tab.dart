part of '../../../places_page.dart';

class _PlacesInTripTab extends StatelessWidget {
  const _PlacesInTripTab({
    required TripPlaces placesInTrip,
  }) : _placesInTrip = placesInTrip;

  final TripPlaces _placesInTrip;

  @override
  Widget build(BuildContext context) {
    if (_placesInTrip.isEmpty) {
      return const Center(
        child: Text('No places added to trip yet'),
      );
    }
    return CustomScrollView(slivers: [
      const SliverToBoxAdapter(
        child: SizedBox(height: 12),
      ),
      SliverList.builder(
        itemCount: _placesInTrip.discoveredPlaces.length,
        itemBuilder: (context, index) => _PlacesListItem(
          place: _placesInTrip.discoveredPlaces[index],
          togglePlace: context.read<PlacesCubit>().toggleDiscoveredPlace,
          isInTrip: true,
        ),
      ),
      SliverList.builder(
        itemCount: _placesInTrip.customPlaces.length,
        itemBuilder: (context, index) => _PlacesListItem(
          place: _placesInTrip.customPlaces[index],
          togglePlace: context.read<PlacesCubit>().toggleCustomPlace,
          isInTrip: true,
        ),
      ),
    ]);
  }
}
