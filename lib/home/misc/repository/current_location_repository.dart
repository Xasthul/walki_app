import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationRepository {
  Stream<LatLng> get currentLocationStream => Geolocator.getPositionStream().transform(_positionTransformer);

  final _positionTransformer = StreamTransformer<Position, LatLng>.fromHandlers(
    handleData: (position, sink) {
      sink.add(LatLng(position.latitude, position.longitude));
    },
  );

  Future<LatLng> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }
}
