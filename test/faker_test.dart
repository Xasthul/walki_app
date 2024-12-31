import 'package:faker/faker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/misc/entity/place.dart';
import 'package:vall/home/misc/network/entity/request/search_nearby/search_nearby_place_type.dart';
import 'package:vall/home/profile/misc/entity/visited_place.dart';

final faker = Faker();

final fakeGooglePlace = GooglePlace(
  name: faker.randomGenerator.string(10),
  latitude: faker.geo.latitude(),
  longitude: faker.geo.longitude(),
  id: faker.guid.guid(),
  photoUrl: faker.internet.httpsUrl(),
  summary: faker.lorem.sentence(),
  rating: faker.randomGenerator.decimal(),
  isOpen: faker.randomGenerator.boolean(),
  nextOpenTime: faker.date.dateTime(),
  nextCloseTime: faker.date.dateTime(),
  type: faker.randomGenerator.element(SearchNearbyPlaceType.values),
);

final fakeVisitedPlace = VisitedPlace(
  name: faker.randomGenerator.string(10),
  latitude: faker.geo.latitude(),
  longitude: faker.geo.longitude(),
);

final fakeLatLng = LatLng(
  faker.geo.latitude(),
  faker.geo.longitude(),
);
