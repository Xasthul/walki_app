part of '../../../places_page.dart';

class _PlacesListItem extends StatelessWidget {
  const _PlacesListItem({
    required PointOfInterest place,
    required Function(PointOfInterest) togglePlace,
    required bool isInTrip,
  })  : _place = place,
        _togglePlace = togglePlace,
        _isInTrip = isInTrip;

  final PointOfInterest _place;
  final Function(PointOfInterest) _togglePlace;
  final bool _isInTrip;

  @override
  Widget build(BuildContext context) => Row(children: [
        CachedNetworkImage(
          imageUrl: _place.photoUrl,
          width: 64,
          height: 40,
          placeholder: (context, url) => const Center(child: AppLoadingIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.image_rounded),
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(_place.name),
        ),
        AppTextButton(
          onPressed: () => _togglePlace(_place),
          label: _isInTrip //
              ? 'Remove'
              : 'Add',
        ),
      ]);
}
