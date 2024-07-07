import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripComponent extends StatefulWidget {
  const TripComponent({
    super.key,
    required LatLng initialLocation,
  }) : _initialLocation = initialLocation;

  final LatLng _initialLocation;

  @override
  State<TripComponent> createState() => _TripComponentState();
}

class _TripComponentState extends State<TripComponent> {
  late Completer<GoogleMapController> _controller;
  static const double _initialCameraZoom = 14.5;

  @override
  void initState() {
    super.initState();
    _controller = Completer<GoogleMapController>();
  }

  @override
  Widget build(BuildContext context) => GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget._initialLocation,
          zoom: _initialCameraZoom,
        ),
        onMapCreated: _controller.complete,
        compassEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        minMaxZoomPreference: const MinMaxZoomPreference(15, 17),
      );
}
