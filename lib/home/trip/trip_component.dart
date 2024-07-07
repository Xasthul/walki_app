import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';
import 'package:vall/home/trip/settings/trip_settings_component.dart';

class TripComponent extends StatefulWidget {
  const TripComponent({super.key});

  @override
  State<TripComponent> createState() => _TripComponentState();
}

class _TripComponentState extends State<TripComponent> {
  late TripCubit _cubit;
  late Completer<GoogleMapController> _controller;
  static const double _initialCameraZoom = 14.5;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<TripCubit>(context);
    _controller = Completer<GoogleMapController>();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        top: false,
        child: BlocBuilder<TripCubit, TripState>(builder: (context, state) {
          if (state is TripInitialLocationLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _cubit.location,
                zoom: _initialCameraZoom,
              ),
              onMapCreated: _controller.complete,
              polylines: {
                if (state is TripCreated)
                  Polyline(
                    polylineId: state.polylineId,
                    color: Colors.red,
                    points: state.polylinePoints,
                    width: 8,
                  ),
              },
              compassEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              minMaxZoomPreference: const MinMaxZoomPreference(15, 17),
            ),
            const TripSettingsComponent(),
            if (state is TripLoading)
              AbsorbPointer(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white.withOpacity(0.6),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
          ]);
        }),
      );
}
