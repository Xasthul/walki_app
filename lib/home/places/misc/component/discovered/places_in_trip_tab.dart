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
        itemBuilder: (context, index) => _buildItem(
          place: _placesInTrip.discoveredPlaces[index],
          onRemove: context.read<PlacesCubit>().toggleDiscoveredPlace,
        ),
      ),
      SliverList.builder(
        itemCount: _placesInTrip.customPlaces.length,
        itemBuilder: (context, index) => _buildItem(
          place: _placesInTrip.customPlaces[index],
          onRemove: context.read<PlacesCubit>().toggleCustomPlace,
        ),
      ),
    ]);
  }

  Widget _buildItem({
    required PointOfInterest place,
    required Function(PointOfInterest) onRemove,
  }) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Flexible(
          child: Text(place.name),
        ),
        AppTextButton(
          onPressed: () => onRemove(place),
          label: 'Remove',
        ),
      ]);
}
