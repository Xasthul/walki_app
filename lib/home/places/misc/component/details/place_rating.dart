part of 'place_details.dart';

class _PlaceRating extends StatelessWidget {
  const _PlaceRating({
    required GooglePlace place,
  }) : _place = place;

  final GooglePlace _place;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rating',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          if (_place.rating == null)
            const Text('No data about rating available')
          else
            Row(
              children: [
                RatingBar.builder(
                  initialRating: _place.rating!,
                  allowHalfRating: true,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber[600],
                  ),
                  unratedColor: Colors.amber[100],
                  onRatingUpdate: (_) {},
                  ignoreGestures: true,
                  itemSize: 24,
                ),
                const SizedBox(width: 8),
                Text('${_place.rating}'),
              ],
            ),
        ],
      );
}
