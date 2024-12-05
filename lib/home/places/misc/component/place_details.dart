import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vall/home/misc/entity/place.dart';
import 'package:vall/home/misc/navigator/home_navigator.dart';
import 'package:vall/home/places/misc/component/place_image.dart';

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
                  Center(
                    child: PlaceImage(url: _place.photoUrl),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _place.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  if (_place.rating != null) ...[
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
                  const SizedBox(height: 24),
                  if (_place.summary != null) Text(_place.summary!) else const Text('No description provided'),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      );
}
