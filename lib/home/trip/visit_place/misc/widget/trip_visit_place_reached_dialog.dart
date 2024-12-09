part of '../../trip_visit_place_listener.dart';

class _TripVisitPlaceReachedDialog extends StatelessWidget {
  const _TripVisitPlaceReachedDialog({
    required GooglePlace place,
  }) : _place = place;

  final GooglePlace _place;

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
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _place.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: AppFilledButton(
              onPressed: () {
                // TODO(Naz): push review creation
                Navigator.of(context).pop();
                context.read<TripVisitPlaceCubit>().markPlaceAsVisited(_place);
              },
              label: 'Share your impressions',
            ),
          ),
          Center(
            child: AppOutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<TripVisitPlaceCubit>().markPlaceAsVisited(_place);
              },
              label: 'Continue the trip',
            ),
          ),
        ],
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        backgroundColor: AppColors.white,
      );
}
