import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/app/common/constants/app_constants.dart';

class TripComponent extends StatefulWidget {
  const TripComponent({super.key});

  @override
  State<TripComponent> createState() => _TripComponentState();
}

class _TripComponentState extends State<TripComponent> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  Map<PolylineId, Polyline> polylines = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(54.893482985083764, 23.922701572619054),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) => GoogleMap(
        initialCameraPosition: _kGooglePlex,
        onMapCreated: _controller.complete,
        polylines: Set<Polyline>.of(polylines.values),
        compassEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        // cameraTargetBounds: CameraTargetBounds(LatLngBounds()),
        minMaxZoomPreference: const MinMaxZoomPreference(15, 17),
      );

  Future<void> _createPolylines() async {
    final polylinePoints = PolylinePoints();
    final List<LatLng> polylineCoordinates = [];

    final PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: const PointLatLng(54.893482985083764, 23.922701572619054),
        destination: const PointLatLng(54.897365892302616, 23.91082727202179),
        wayPoints: [
          PolylineWayPoint(location: const LatLng(54.89503602818858, 23.924917182255633).coordinates),
          PolylineWayPoint(location: const LatLng(54.89875143315223, 23.924199291557137).coordinates),
        ],
        mode: TravelMode.walking,
      ),
      googleApiKey: AppConstants.googleApiKey,
    );

    if (result.points.isNotEmpty) {
      for (final point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    const PolylineId id = PolylineId('poly');

    final Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 8,
    );

    polylines[id] = polyline;

    setState(() {});
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    (await _controller.future).animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18.0,
        ),
      ),
    );
    setState(() {});
  }
}

extension LatLangX on LatLng {
  String get coordinates => '$latitude, $longitude';
}
