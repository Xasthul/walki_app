import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vall/home/trip/trip_component.dart';
import 'package:vall/home/trip_settings/trip_settings_component.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => const AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            top: false,
            child: Stack(children: [
              TripComponent(),
              TripSettingsComponent(),
            ]),
          ),
        ),
      );
}
