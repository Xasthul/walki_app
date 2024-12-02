part of '../../../places_page.dart';

class _PlacesDiscoveredOthersTab extends StatelessWidget {
  const _PlacesDiscoveredOthersTab({
    required List<PointOfInterest> discoveredRestaurants,
    required List<PointOfInterest> discoveredCafes,
    required List<PointOfInterest> placesInTrip,
  })  : _discoveredRestaurants = discoveredRestaurants,
        _discoveredCafes = discoveredCafes,
        _placesInTrip = placesInTrip;

  final List<PointOfInterest> _discoveredRestaurants;
  final List<PointOfInterest> _discoveredCafes;
  final List<PointOfInterest> _placesInTrip;

  @override
  Widget build(BuildContext context) => CustomScrollView(slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(height: 12),
        ),
        if (_discoveredRestaurants.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: _buildSectionTitle('Restaurants'),
          ),
          SliverList.builder(
            itemCount: _discoveredRestaurants.length,
            itemBuilder: (context, index) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Flexible(
                child: Text(_discoveredRestaurants[index].name),
              ),
              AppTextButton(
                onPressed: () => context.read<PlacesCubit>().toggleDiscoveredPlace(_discoveredRestaurants[index]),
                label: _placesInTrip.contains(_discoveredRestaurants[index]) //
                    ? 'Remove'
                    : 'Add',
              ),
            ]),
          ),
        ],
        if (_discoveredCafes.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: _buildSectionTitle('Cafes'),
          ),
          SliverList.builder(
            itemCount: _discoveredCafes.length,
            itemBuilder: (context, index) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Flexible(
                child: Text(_discoveredCafes[index].name),
              ),
              AppTextButton(
                onPressed: () => context.read<PlacesCubit>().toggleDiscoveredPlace(_discoveredCafes[index]),
                label: _placesInTrip.contains(_discoveredCafes[index]) //
                    ? 'Remove'
                    : 'Add',
              ),
            ]),
          ),
        ],
      ]);

  Widget _buildSectionTitle(String label) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 16),
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        const Divider(),
      ]);
}
