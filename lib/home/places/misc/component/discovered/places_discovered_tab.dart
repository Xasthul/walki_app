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
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: _discoveredPlaces.length,
          itemBuilder: (context, index) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
              child: Text(_discoveredPlaces[index].name),
            ),
            TextButton(
              onPressed: () => context.read<PlacesCubit>().togglePlace(_discoveredPlaces[index]),
              child: _placesInTrip.contains(_discoveredPlaces[index]) //
                  ? const Text('Remove')
                  : const Text('Add'),
            ),
          ]),
        ),
      );
}
