part of '../../../places_page.dart';

class _PlacesListItem extends StatelessWidget {
  const _PlacesListItem({
    required Place place,
    required Function(Place) togglePlace,
    required bool isInTrip,
  })  : _place = place,
        _togglePlace = togglePlace,
        _isInTrip = isInTrip;

  final Place _place;
  final Function(Place) _togglePlace;
  final bool _isInTrip;

  @override
  Widget build(BuildContext context) => Row(children: [
        if (_place is GooglePlace)
          PlaceImage(
            url: _place.photoUrl,
            width: 64,
            height: 40,
            fit: BoxFit.cover,
          )
        else
          const Icon(Icons.image_rounded),
        const SizedBox(width: 8),
        Expanded(
          child: Text(_place.name),
        ),
        if (_place is GooglePlace)
          AppTextButton(
            onPressed: () => HomeNavigator.of(context).navigateToPlaceDetails(_place),
            label: 'Details',
          )
        else
          AppTextButton(
            onPressed: () => _togglePlace(_place),
            label: _isInTrip //
                ? 'Remove'
                : 'Add',
          ),
      ]);
}
