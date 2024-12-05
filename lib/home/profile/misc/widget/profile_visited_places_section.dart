part of '../../profile_page.dart';

class _ProfileVisitedPlacesSection extends StatelessWidget {
  const _ProfileVisitedPlacesSection({
    required List<VisitedPlace> visitedPlaces,
  }) : _visitedPlaces = visitedPlaces;

  final List<VisitedPlace> _visitedPlaces;

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
            Text(
              'You have visited ${_visitedPlaces.length} places: ',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: _visitedPlaces.length,
                itemBuilder: (context, index) => _ProfileVisitedPlacesListItem(
                  place: _visitedPlaces[index],
                  index: index,
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
