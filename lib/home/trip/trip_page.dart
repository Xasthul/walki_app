import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/component/app_loading_indicator.dart';
import 'package:vall/home/trip/common/component/trip_map_component.dart';
import 'package:vall/home/trip/common/component/trip_settings_component.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';

class TripPage extends StatelessWidget {
  const TripPage({super.key});

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: SafeArea(
            top: false,
            child: BlocBuilder<TripCubit, TripState>(builder: (context, state) {
              if (state is TripCurrentLocationLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Stack(children: [
                const TripMapComponent(),
                const TripSettingsComponent(),
                if (state is TripLoading) const AppLoadingIndicator(),
              ]);
            }),
          ),
        ),
      );
}
