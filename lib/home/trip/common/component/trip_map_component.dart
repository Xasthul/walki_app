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
          minMaxZoomPreference: const MinMaxZoomPreference(15, 17),
        ),
      );

  Set<Marker> _getMarkers(TripState state) => {
        ...switch (state) {
          TripPlacesNearbyFound() => state.places.map(
              (place) => Marker(
                markerId: MarkerId('$place'),
                position: place,
                icon: _foundPlaceMarkerIcon,
              ),
            ),
          TripCreation() => {
              ...state.places.map(
                (place) => Marker(
                  markerId: MarkerId('$place'),
                  position: place,
                  icon: _foundPlaceMarkerIcon,
                ),
              ),
              ...state.selectedPlaces.map(
                (place) => Marker(
                  markerId: MarkerId('$place'),
                  position: place,
                  icon: _selectedPlaceMarkerIcon,
                ),
              ),
            },
          TripCreated() => state.places.map(
              (place) => Marker(
                markerId: MarkerId('$place'),
                position: place,
                icon: _selectedPlaceMarkerIcon,
              ),
            ),
          _ => {},
        }
      };

  BitmapDescriptor get _selectedPlaceMarkerIcon => BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);

  BitmapDescriptor get _foundPlaceMarkerIcon => BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta);
}
