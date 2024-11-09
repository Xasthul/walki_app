part of '../../profile_page.dart';

class _ProfileVisitedPlacesSection extends StatelessWidget {
  const _ProfileVisitedPlacesSection({
    required List<PointOfInterest> visitedPlaces,
  }) : _visitedPlaces = visitedPlaces;

  final List<PointOfInterest> _visitedPlaces;

  @override
  Widget build(BuildContext context) {
    if (_visitedPlaces.isEmpty) {
      return const _ProfileVisitedPlacesListEmpty();
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You have visited ${_visitedPlaces.length} places: '),
            Expanded(
              child: ListView.builder(
                itemCount: _visitedPlaces.length,
                itemBuilder: (context, index) => _ProfileVisitedPlacesListItem(place: _visitedPlaces[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
