part of '../../../places_page.dart';

class _PlacesInTripTab extends StatelessWidget {
  const _PlacesInTripTab({
    required List<PointOfInterest> placesInTrip,
  }) : _placesInTrip = placesInTrip;

  final List<PointOfInterest> _placesInTrip;

  @override
  Widget build(BuildContext context) {
    if (_placesInTrip.isEmpty) {
      return const Center(
        child: Text('No places added to trip yet'),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: _placesInTrip.length,
        itemBuilder: (context, index) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Flexible(
            child: Text(_placesInTrip[index].name),
          ),
          TextButton(
            onPressed: () => context.read<PlacesCubit>().togglePlace(_placesInTrip[index]),
            child: const Text('Remove'),
          ),
        ]),
      ),
    );
  }
}
