import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/theme/app_colors.dart';
import 'package:vall/app/common/widget/app_filled_button.dart';
import 'package:vall/app/common/widget/app_outlined_button.dart';
import 'package:vall/home/misc/entity/place.dart';
import 'package:vall/home/misc/navigator/home_navigator.dart';
import 'package:vall/home/trip/visit_place/cubit/trip_visit_place_cubit.dart';

class TripVisitPlaceReachedDialog extends StatelessWidget {
  const TripVisitPlaceReachedDialog({
    super.key,
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
                HomeNavigator.of(context).navigateToCreatePlaceReview(place: _place);
                context.read<TripVisitPlaceCubit>().markPlaceAsVisited(_place);
              },
              label: 'Share your impressions',
            ),
          ),
          Center(
            child: AppOutlinedButton(
              onPressed: () {
                HomeNavigator.of(context).pop();
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
