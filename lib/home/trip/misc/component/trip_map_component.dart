import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';

class TripMapComponent extends StatefulWidget {
  const TripMapComponent({super.key});

  @override
  State<TripMapComponent> createState() => _TripMapComponentState();
}

class _TripMapComponentState extends State<TripMapComponent> {
  late TripCubit _cubit;
  late Completer<GoogleMapController> _controller;
  static const double _initialCameraZoom = 14.5;
  static const PolylineId _tripPolylineId = PolylineId('trip');

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<TripCubit>(context);
    _controller = Completer<GoogleMapController>();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<TripCubit, TripState>(
        builder: (context, state) => GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _cubit.location,
            zoom: _initialCameraZoom,
          ),
          onMapCreated: _controller.complete,
          polylines: {
            if (state is TripCreated)
              Polyline(
                polylineId: _tripPolylineId,
                color: Colors.blueAccent,
                points: state.polylinePoints,
                width: 8,
              ),
          },
          markers: _getMarkers(state),
          compassEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
        ),
      );

  Set<Marker> _getMarkers(TripState state) => {
        ...switch (state) {
          TripPlacesNearbyFound() => _drawMarkers(
              places: state.places,
              icon: _foundPlaceMarkerIcon,
            ),
          TripCreation() => {
              ..._drawMarkers(
                places: state.places,
                icon: _foundPlaceMarkerIcon,
              ),
              ..._drawMarkers(
                places: state.places,
                icon: _selectedPlaceMarkerIcon,
              ),
            },
          TripCreated() => _drawMarkers(
              places: state.places,
              icon: _selectedPlaceMarkerIcon,
            ),
          _ => {},
        }
      };

  Iterable<Marker> _drawMarkers({
    required List<LatLng> places,
    required BitmapDescriptor icon,
  }) =>
      places.map(
        (place) => Marker(
          markerId: MarkerId('$place'),
          position: place,
          icon: _selectedPlaceMarkerIcon,
        ),
      );

  BitmapDescriptor get _selectedPlaceMarkerIcon => BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);

  BitmapDescriptor get _foundPlaceMarkerIcon => BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta);
}
