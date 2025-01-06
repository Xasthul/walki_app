import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/widget/app_filled_button.dart';
import 'package:vall/app/common/widget/app_loading_cover.dart';
import 'package:vall/app/common/widget/app_snack_bar.dart';
import 'package:vall/app/common/widget/app_text_field.dart';
import 'package:vall/home/misc/entity/place.dart';
import 'package:vall/home/misc/navigator/home_navigator.dart';
import 'package:vall/home/trip/visit_place/create_place_review/create_place_review_dependencies.dart';
import 'package:vall/home/trip/visit_place/create_place_review/cubit/create_place_review_cubit.dart';
import 'package:vall/home/trip/visit_place/cubit/trip_visit_place_cubit.dart';

class CreatePlaceReviewPage extends StatelessWidget {
  const CreatePlaceReviewPage({
    super.key,
    required GooglePlace place,
  }) : _place = place;

  final GooglePlace _place;

  @override
  Widget build(BuildContext context) => CreatePlaceReviewDependencies(
        googlePlaceId: _place.id,
        child: const _CreatePlaceReviewPageBase(),
      );
}

class _CreatePlaceReviewPageBase extends StatefulWidget {
  const _CreatePlaceReviewPageBase();

  @override
  State<_CreatePlaceReviewPageBase> createState() => _CreatePlaceReviewPageBaseState();
}

class _CreatePlaceReviewPageBaseState extends State<_CreatePlaceReviewPageBase> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => BlocListener<CreatePlaceReviewCubit, CreatePlaceReviewState>(
        listener: (context, state) {
          if (state is CreatePlaceReviewSuccessful) {
            context.read<TripVisitPlaceCubit>().resetState();
            HomeNavigator.of(context).popUntilFirst();
            ScaffoldMessenger.of(context).showInfoSnackBar(text: 'Thanks for sharing!');
            return;
          }
          if (state is CreatePlaceReviewFailed) {
            ScaffoldMessenger.of(context).showErrorSnackBar(text: 'Something went wrong');
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Place Review'),
            leading: IconButton(
              onPressed: HomeNavigator.of(context).pop,
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          body: SafeArea(
            child: BlocBuilder<CreatePlaceReviewCubit, CreatePlaceReviewState>(
              builder: (context, state) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        AppTextField(
                          controller: _controller,
                          hint: 'Share your thoughts about the place here',
                          maxLines: 7,
                          maxLength: 150,
                        ),
                        const SizedBox(height: 16),
                        AppFilledButton(
                          onPressed: () =>
                              context.read<CreatePlaceReviewCubit>().createPlaceReview(content: _controller.text),
                          label: 'Submit review',
                        ),
                      ],
                    ),
                    if (state is CreatePlaceReviewLoading) const AppLoadingCover(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
