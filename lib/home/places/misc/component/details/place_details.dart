import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vall/home/misc/entity/place.dart';
import 'package:vall/home/misc/navigator/home_navigator.dart';
import 'package:vall/home/places/misc/component/place_image.dart';
import 'package:vall/l10n/generated/app_localizations.dart';

part 'place_rating.dart';

part 'place_summary.dart';

part 'place_working_time.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({
    super.key,
    required GooglePlace place,
  }) : _place = place;

  final GooglePlace _place;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Place Details'),
          leading: IconButton(
            onPressed: HomeNavigator.of(context).pop,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: PlaceImage(url: _place.photoUrl),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _place.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  _PlaceRating(place: _place),
                  const SizedBox(height: 20),
                  _PlaceWorkingTime(place: _place),
                  const SizedBox(height: 20),
                  _PlaceSummary(place: _place),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      );
}
