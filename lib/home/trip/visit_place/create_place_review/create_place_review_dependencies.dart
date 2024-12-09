import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/misc/repository/place_reviews_repository.dart';
import 'package:vall/home/trip/visit_place/create_place_review/cubit/create_place_review_cubit.dart';

class CreatePlaceReviewDependencies extends StatelessWidget {
  const CreatePlaceReviewDependencies({
    super.key,
    required String googlePlaceId,
    required Widget child,
  })  : _googlePlaceId = googlePlaceId,
        _child = child;

  final String _googlePlaceId;
  final Widget _child;

  @override
  Widget build(BuildContext context) => BlocProvider<CreatePlaceReviewCubit>(
        create: (context) => CreatePlaceReviewCubit(
          googlePlaceId: _googlePlaceId,
          placeReviewsRepository: context.read<PlaceReviewsRepository>(),
        ),
        child: _child,
      );
}
