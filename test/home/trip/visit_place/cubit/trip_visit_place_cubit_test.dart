import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:vall/home/misc/repository/current_location_repository.dart';
import 'package:vall/home/profile/misc/repository/visited_places_repository.dart';
import 'package:vall/home/trip/visit_place/cubit/trip_visit_place_cubit.dart';
import 'package:vall/home/trip/visit_place/misc/mapper/visited_place_mapper.dart';
import 'package:vall/home/trip/visit_place/misc/repository/trip_visit_place_repository.dart';

import '../../../../faker_test.dart';
@GenerateNiceMocks([
  MockSpec<CurrentLocationRepository>(),
  MockSpec<VisitedPlacesRepository>(),
  MockSpec<TripVisitPlaceRepository>(),
  MockSpec<VisitedPlaceMapper>(),
])
import 'trip_visit_place_cubit_test.mocks.dart';

void main() {
  late CurrentLocationRepository currentLocationRepository;
  late VisitedPlacesRepository visitedPlacesRepository;
  late TripVisitPlaceRepository tripVisitPlaceRepository;
  late VisitedPlaceMapper visitedPlaceMapper;
  late TripVisitPlaceCubit cubit;

  setUp(() {
    currentLocationRepository = MockCurrentLocationRepository();
    visitedPlacesRepository = MockVisitedPlacesRepository();
    tripVisitPlaceRepository = MockTripVisitPlaceRepository();
    visitedPlaceMapper = MockVisitedPlaceMapper();
    cubit = TripVisitPlaceCubit(
      currentLocationRepository: currentLocationRepository,
      visitedPlacesRepository: visitedPlacesRepository,
      tripVisitPlaceRepository: tripVisitPlaceRepository,
      visitedPlaceMapper: visitedPlaceMapper,
    );
  });

  tearDown(() => cubit.onTripFinished());

  test(
      'Given visitedPlacesRepository loadVisitedPlaces is successful '
      'When load is called '
      'Then TripVisitPlaceLoaded state is emitted', () async {
    when(visitedPlacesRepository.loadVisitedPlaces()).thenAnswer((_) async => [fakeVisitedPlace]);

    await cubit.load();

    expect(
      cubit.state,
      TripVisitPlaceLoaded(visitedPlaces: [fakeVisitedPlace]),
    );
  });

  test(
      'Given visitedPlacesRepository loadVisitedPlaces is successful '
      'When load is called '
      'Then TripVisitPlaceLoaded state is emitted', () async {
    when(visitedPlacesRepository.loadVisitedPlaces()).thenAnswer((_) async => [fakeVisitedPlace]);

    await cubit.load();

    expect(
      cubit.state,
      TripVisitPlaceLoaded(visitedPlaces: [fakeVisitedPlace]),
    );
  });

  test(
      'Given visitedPlaceMapper mapVisitedPlaceFromPlace is successful '
      'When markPlaceAsVisited is called '
      'Then TripVisitPlaceMarked state is emitted', () async {
    when(visitedPlaceMapper.mapVisitedPlaceFromPlace(fakeGooglePlace)).thenReturn(fakeVisitedPlace);

    await cubit.markPlaceAsVisited(fakeGooglePlace);

    expect(
      cubit.state,
      TripVisitPlaceMarked(visitedPlaces: [fakeVisitedPlace]),
    );
  });

  test(
      'Given visitedPlacesRepository visitPlace throws an error '
      'When markPlaceAsVisited is called '
      'Then TripVisitPlaceMarked state is not emitted', () async {
    final expectedError = Exception();
    when(visitedPlaceMapper.mapVisitedPlaceFromPlace(fakeGooglePlace)).thenReturn(fakeVisitedPlace);
    when(
      visitedPlacesRepository.visitPlace(
        googlePlaceId: fakeGooglePlace.id,
        place: fakeVisitedPlace,
      ),
    ).thenThrow(expectedError);

    await cubit.markPlaceAsVisited(fakeGooglePlace);

    expect(
      cubit.state.runtimeType,
      isNot(TripVisitPlaceMarked),
    );
  });
}
