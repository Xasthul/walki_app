part of 'place_reviews_page.dart';

class _PlaceReviewItem extends StatelessWidget {
  const _PlaceReviewItem({
    required PlaceReview review,
  }) : _review = review;

  final PlaceReview _review;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).formatPlaceReviewAuthorDate(_review.author, _review.createdAt),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(_review.content),
          ],
        ),
      );
}
