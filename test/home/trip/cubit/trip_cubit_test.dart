import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vall/home/misc/repository/current_location_repository.dart';
import 'package:vall/home/misc/repository/places_repository.dart';
import 'package:vall/home/misc/repository/trip_repository.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';

import '../../../faker_test.dart';
@GenerateNiceMocks([
  MockSpec<CurrentLocationRepository>(),
  MockSpec<TripRepository>(),
  MockSpec<PlacesRepository>(),
])
import 'trip_cubit_test.mocks.dart';

void main() {
  late CurrentLocationRepository currentLocationRepository;
  late TripRepository tripRepository;
  late PlacesRepository placesRepository;
  late TripCubit cubit;

  setUp(() {
    currentLocationRepository = MockCurrentLocationRepository();
    tripRepository = MockTripRepository();
    placesRepository = MockPlacesRepository();
    cubit = TripCubit(
      tripRepository: tripRepository,
      placesRepository: placesRepository,
      currentLocationRepository: currentLocationRepository,
    );
  });

  group(
      'Given a place is selected for trip '
      'And currentLocationRepository getCurrentLocation is successful', () {
    setUp(() {
      when(tripRepository.tripStream).thenAnswer((_) => Stream.value([fakeGooglePlace]));
      cubit.load();
      when(currentLocationRepository.getCurrentLocation()).thenAnswer((_) async => fakeLatLng);
    });

    test(
        'And currentLocationRepository getCurrentLocation is successful '
        'And tripRepository getPolylineCoordinates is successful '
        'When createTrip is called '
        'Then state is set to TripCreated '
        'And tripRepository getPolylineCoordinates is called', () async {
      when(
        tripRepository.getPolylineCoordinates(
          places: [fakeGooglePlace],
          currentLocation: fakeLatLng,
        ),
      ).thenAnswer((_) async => [fakeLatLng]);

      await cubit.createTrip();

      expect(
        cubit.state,
        isA<TripCreated>(),
      );
      verify(
        tripRepository.getPolylineCoordinates(
          places: [fakeGooglePlace],
          currentLocation: fakeLatLng,
        ),
      );
    });

    test(
        'And tripRepository getPolylineCoordinates throws an error '
        'When createTrip is called '
        'Then state is set to TripCreated', () async {
      final error = Exception();
      when(
        tripRepository.getPolylineCoordinates(
          places: [fakeGooglePlace],
          currentLocation: fakeLatLng,
        ),
      ).thenThrow(error);

      await cubit.createTrip();

      expect(
        cubit.state,
        isA<TripCreationFailed>(),
      );
    });
  });

  test(
      'Given search radius is set '
      'And currentLocationRepository getCurrentLocation is successful '
      'When findPlaces is called '
      'Then state is set to TripPlacesNearbyFound '
      'And placesRepository findPlaces is called', () async {
    const searchRadius = 500.0;
    cubit.updateSearchRadius(searchRadius);
    when(currentLocationRepository.getCurrentLocation()).thenAnswer((_) async => fakeLatLng);
    when(
      placesRepository.findPlaces(
        startingPosition: fakeLatLng,
        radius: searchRadius,
      ),
    ).thenAnswer((_) async => [fakeGooglePlace]);

    await cubit.findPlaces();

    expect(
      cubit.state,
      isA<TripPlacesNearbyFound>(),
    );
    verify(
      placesRepository.findPlaces(
        startingPosition: fakeLatLng,
        radius: searchRadius,
      ),
    );
  });
}
