import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vall/home/misc/repository/place_reviews_repository.dart';
import 'package:vall/home/trip/visit_place/create_place_review/cubit/create_place_review_cubit.dart';

@GenerateNiceMocks([
  MockSpec<PlaceReviewsRepository>(),
])
import 'create_place_review_cubit_test.mocks.dart';

void main() {
  late PlaceReviewsRepository placeReviewsRepository;
  late CreatePlaceReviewCubit cubit;

  const googlePlaceId = 'googlePlaceId';
  const content = 'content';

  setUp(() {
    placeReviewsRepository = MockPlaceReviewsRepository();
    cubit = CreatePlaceReviewCubit(
      googlePlaceId: googlePlaceId,
      placeReviewsRepository: placeReviewsRepository,
    );
  });

  blocTest(
    'When createPlaceReview is called '
    'Then CreatePlaceReviewLoading state is emitted '
    'And CreatePlaceReviewSuccessful state is emitted '
    'And placeReviewsRepository createPlaceReview is called',
    build: () => cubit,
    act: (cubit) async => cubit.createPlaceReview(content: content),
    expect: () => [
      CreatePlaceReviewLoading(),
      CreatePlaceReviewSuccessful(),
    ],
    verify: (_) => verify(
      placeReviewsRepository.createPlaceReview(
        googlePlaceId: googlePlaceId,
        content: content,
      ),
    ),
  );
}
