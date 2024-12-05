part of 'place_details.dart';

class _PlaceWorkingTime extends StatelessWidget {
  const _PlaceWorkingTime({
    required GooglePlace place,
  }) : _place = place;

  final GooglePlace _place;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Working hours',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          if (_place.isOpen == null)
            const Text('No data about working hours available')
          else
            Row(
              children: [
                Text(
                  _place.isOpen! ? 'Open' : 'Closed',
                  style: TextStyle(
                    color: _place.isOpen! ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (_place.isOpen! && _place.nextCloseTime != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context).formatPlaceClosesAt(_place.nextCloseTime!),
                  ),
                ],
                if (!_place.isOpen! && _place.nextOpenTime != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context).formatPlaceOpensAt(_place.nextOpenTime!),
                  ),
                ],
              ],
            ),
        ],
      );
}
