part of '../../profile_page.dart';

class _ProfileVisitedPlacesListItem extends StatelessWidget {
  const _ProfileVisitedPlacesListItem({
    required PointOfInterest place,
  }) : _place = place;

  final PointOfInterest _place;

  @override
  Widget build(BuildContext context) => Text(_place.name);
}
