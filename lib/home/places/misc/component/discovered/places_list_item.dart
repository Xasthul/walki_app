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
          CachedNetworkImage(
            imageUrl: _place.photoUrl,
            width: 64,
            height: 40,
            placeholder: (context, url) => const Center(child: AppLoadingIndicator()),
            errorWidget: (context, url, error) => _imagePlaceholder,
            fit: BoxFit.cover,
          )
        else
          _imagePlaceholder,
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

  Icon get _imagePlaceholder => const Icon(Icons.image_rounded);
}
