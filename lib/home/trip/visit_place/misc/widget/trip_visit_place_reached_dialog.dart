part of '../../trip_visit_place_listener.dart';

class _TripVisitPlaceReachedDialog extends StatelessWidget {
  const _TripVisitPlaceReachedDialog({
    required PointOfInterest place,
  }) : _place = place;

  final PointOfInterest _place;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text(
          'Congratulations!',
          textAlign: TextAlign.center,
        ),
        content: Text(
          "You've reached:\n\"${_place.name}\"!",
          textAlign: TextAlign.center,
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<TripVisitPlaceCubit>().markPlaceAsVisited(_place);
            },
            child: const Text(
              'Mark as visited',
            ),
          ),
        ],
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
      );
}
