part of '../../../places_page.dart';

class _PlacesInTripTab extends StatelessWidget {
  const _PlacesInTripTab({
    required List<Place> placesInTrip,
  }) : _placesInTrip = placesInTrip;

  final List<Place> _placesInTrip;

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
        itemCount: _placesInTrip.length,
        itemBuilder: (context, index) => _PlacesListItem(
          place: _placesInTrip[index],
          togglePlace: context.read<PlacesCubit>().togglePlace,
          isInTrip: true,
        ),
      ),
      SliverList.builder(
        itemCount: _placesInTrip.length,
        itemBuilder: (context, index) => _PlacesListItem(
          place: _placesInTrip[index],
          togglePlace: context.read<PlacesCubit>().togglePlace,
          isInTrip: true,
        ),
      ),
    ]);
  }
}
