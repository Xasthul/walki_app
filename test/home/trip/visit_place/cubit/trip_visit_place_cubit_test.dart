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
      'When resetState is called '
      'Then TripVisitPlaceInitial state is emitted', () {
    cubit.resetState();

    expect(
      cubit.state,
      const TripVisitPlaceInitial(visitedPlaces: []),
    );
  });
}
