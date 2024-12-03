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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'You have reached:',
              style: TextStyle(
                fontSize: 16
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _place.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          AppFilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<TripVisitPlaceCubit>().markPlaceAsVisited(_place);
            },
            label: 'Mark as visited',
          ),
        ],
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        backgroundColor: AppColors.white,
      );
}
