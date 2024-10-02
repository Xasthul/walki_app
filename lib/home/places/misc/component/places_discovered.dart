part of '../../places_page.dart';

class _PlacesDiscovered extends StatelessWidget {
  const _PlacesDiscovered({
    required List<PointOfInterest> places,
  }) : _places = places;

  final List<PointOfInterest> _places;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: _places.length,
          itemBuilder: (context, index) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
              child: Text(_places[index].name),
            ),
            TextButton(
              onPressed: () => context.read<PlacesCubit>().addPlaceToTrip(_places[index]),
              child: const Text('Add to trip'),
            ),
          ]),
        ),
      );
}
