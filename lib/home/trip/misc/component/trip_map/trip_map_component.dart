import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';

part 'trip_map_place_selection.dart';

class TripMapComponent extends StatefulWidget {
  const TripMapComponent({
    super.key,
    required LatLng initialLocation,
  }) : _initialLocation = initialLocation;

  final LatLng _initialLocation;

  @override
  State<TripMapComponent> createState() => _TripMapComponentState();
}

class _TripMapComponentState extends State<TripMapComponent> {
  late Completer<GoogleMapController> _controller;

  static const double _initialCameraZoom = 14.5;
  static const PolylineId _tripPolylineId = PolylineId('trip');
  static const CircleId _tripCircleId = CircleId('radius');

  LatLng? _addPlace;

  @override
  void initState() {
    super.initState();
    _controller = Completer<GoogleMapController>();
  }

  void _onCameraMove(CameraPosition position, TripState state) {
    if (state is! TripPlaceSelection) {
      return;
    }
    _addPlace = position.target;
  }

  void _onPlaceSelected() {
    if (_addPlace == null) {
      return;
    }
    context.read<TripCubit>().selectPlace(_addPlace!);
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<TripCubit, TripState>(
        builder: (context, state) => Stack(children: [
          GoogleMap(
            padding: state is! TripPlaceSelection //
                ? const EdgeInsets.only(top: 24, bottom: 72)
                : EdgeInsets.zero,
            initialCameraPosition: CameraPosition(
              target: widget._initialLocation,
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
            circles: {
              if (state is! TripCreated)
                Circle(
                  circleId: _tripCircleId,
                  center: widget._initialLocation,
                  radius: state.settings.searchRadius,
                  fillColor: Colors.blueAccent.withOpacity(0.12),
                  strokeWidth: 2,
                  strokeColor: Colors.blueAccent.withOpacity(0.7),
                ),
            },
            compassEnabled: false,
            myLocationEnabled: true,
            onCameraMove: (position) => _onCameraMove(position, state),
          ),
          if (state is TripPlaceSelection) _TripMapPlaceSelection(onPlaceSelected: _onPlaceSelected),
        ]),
      );

  Set<Marker> _getMarkers(TripState state) {
    final tripPlaces = [...state.tripPlaces.discoveredPlaces, ...state.tripPlaces.customPlaces];
    return {
      ...switch (state) {
        TripCreated() => _drawMarkers(
            places: tripPlaces,
            icon: _selectedPlaceMarkerIcon,
          ),
        _ => {
            ..._drawMarkers(
              places: state.foundPlaces.places,
              icon: _foundPlaceMarkerIcon,
            ),
            ..._drawMarkers(
              places: state.foundPlaces.restaurants,
              icon: _foundRestaurantMarkerIcon,
            ),
            ..._drawMarkers(
              places: state.foundPlaces.cafes,
              icon: _foundCafeMarkerIcon,
            ),
            ..._drawMarkers(
              places: tripPlaces,
              icon: _selectedPlaceMarkerIcon,
            ),
          },
      }
    };
  }

  Iterable<Marker> _drawMarkers({
    required List<PointOfInterest> places,
    required BitmapDescriptor icon,
  }) =>
      places.map(
        (place) => Marker(
          markerId: MarkerId('$place'),
          position: LatLng(place.latitude, place.longitude),
          icon: icon,
          infoWindow: InfoWindow(title: place.name),
        ),
      );

  BitmapDescriptor get _selectedPlaceMarkerIcon => BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);

  BitmapDescriptor get _foundPlaceMarkerIcon => BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta);

  BitmapDescriptor get _foundRestaurantMarkerIcon => BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);

  BitmapDescriptor get _foundCafeMarkerIcon => BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
}
