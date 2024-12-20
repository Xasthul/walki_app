import 'package:flutter/material.dart';
import 'package:vall/home/misc/entity/place_review.dart';
import 'package:vall/home/misc/navigator/home_navigator.dart';
import 'package:vall/l10n/generated/app_localizations.dart';

part 'place_review_item.dart';

class PlaceReviewsPage extends StatelessWidget {
  const PlaceReviewsPage({
    super.key,
    required List<PlaceReview> reviews,
  }) : _reviews = reviews;

  final List<PlaceReview> _reviews;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Place Reviews'),
          leading: IconButton(
            onPressed: HomeNavigator.of(context).pop,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _reviews.length,
            itemBuilder: (context, index) => _PlaceReviewItem(review: _reviews[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 12),
          ),
        ),
      );
}
