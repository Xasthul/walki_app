part of '../../profile_page.dart';

class _ProfileVisitedPlacesListItem extends StatelessWidget {
  const _ProfileVisitedPlacesListItem({
    required PointOfInterest place,
    required int index,
  })  : _place = place,
        _index = index;

  final PointOfInterest _place;
  final int _index;

  @override
  Widget build(BuildContext context) => Text(
        '${_index + 1}. ${_place.name}',
        style: const TextStyle(fontSize: 16),
      );
}
