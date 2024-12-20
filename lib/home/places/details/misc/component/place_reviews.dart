part of '../../place_details_page.dart';

class _PlaceReviews extends StatelessWidget {
  const _PlaceReviews();

  @override
  Widget build(BuildContext context) => BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reviews',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            switch (state) {
              PlaceDetailsInitial() => const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text('Loading..'),
                ),
              PlaceDetailsReviewsLoaded() => state.reviews.isEmpty //
                  ? const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('No reviews yet. Be the first one to share your impressions after the visit!'),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('There are ${state.reviews.length} reviews available.'),
                        AppTextButton(
                          label: 'Read',
                          onPressed: () => HomeNavigator.of(context).navigateToPlaceReviews(reviews: state.reviews),
                        ),
                      ],
                    ),
              PlaceDetailsLoadingReviewsFailed() => const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text('Failed to load reviews'),
                ),
            },
          ],
        ),
      );
}
