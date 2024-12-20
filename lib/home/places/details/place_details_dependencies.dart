import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/misc/repository/place_reviews_repository.dart';
import 'package:vall/home/places/details/cubit/place_details_cubit.dart';

class PlaceDetailsDependencies extends StatelessWidget {
  const PlaceDetailsDependencies({
    super.key,
    required String googlePlaceId,
    required Widget child,
  })  : _googlePlaceId = googlePlaceId,
        _child = child;

  final String _googlePlaceId;
  final Widget _child;

  @override
  Widget build(BuildContext context) => BlocProvider<PlaceDetailsCubit>(
        create: (context) => PlaceDetailsCubit(
          googlePlaceId: _googlePlaceId,
          placeReviewsRepository: context.read<PlaceReviewsRepository>(),
        )..load(),
        child: _child,
      );
}
