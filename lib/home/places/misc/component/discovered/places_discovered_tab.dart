part of '../../../places_page.dart';

class _PlacesDiscoveredTab extends StatelessWidget {
  const _PlacesDiscoveredTab({
    required List<PointOfInterest> discoveredPlaces,
    required List<PointOfInterest> placesInTrip,
  })  : _discoveredPlaces = discoveredPlaces,
        _placesInTrip = placesInTrip;

  final List<PointOfInterest> _discoveredPlaces;
  final List<PointOfInterest> _placesInTrip;

  @override
  Widget build(BuildContext context) => ListView.builder(
        padding: const EdgeInsets.only(top: 12),
        itemCount: _discoveredPlaces.length,
        itemBuilder: (context, index) => _PlacesListItem(
          place: _discoveredPlaces[index],
          togglePlace: context.read<PlacesCubit>().toggleDiscoveredPlace,
          isInTrip: _placesInTrip.contains(_discoveredPlaces[index]),
        ),
      );
}
