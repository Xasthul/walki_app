import 'dart:async';

import 'package:vall/home/trip/misc/entity/point_of_interest.dart';
import 'package:vall/home/trip/misc/entity/trip.dart';

class TripRepository {
  Trip _trip = const Trip(places: []);

  final StreamController<Trip?> _tripController = StreamController.broadcast();

  Stream<Trip?> get tripStream => _tripController.stream;

  void addPlace(PointOfInterest place) {
    _trip = _trip.copyWith(places: [..._trip.places, place]);
    _tripController.add(_trip);
  }

  void clearTrip() {
    _trip = Trip.empty();
    _tripController.add(_trip);
  }
}
