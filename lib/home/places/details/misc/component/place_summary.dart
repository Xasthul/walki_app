part of '../../place_details_page.dart';

class _PlaceSummary extends StatelessWidget {
  const _PlaceSummary({
    required GooglePlace place,
  }) : _place = place;

  final GooglePlace _place;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          if (_place.summary != null) //
            Text(_place.summary!)
          else
            const Text('No description provided'),
        ],
      );
}
