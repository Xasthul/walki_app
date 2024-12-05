import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/theme/app_colors.dart';
import 'package:vall/app/common/widget/app_filled_button.dart';
import 'package:vall/app/common/widget/app_text_button.dart';
import 'package:vall/home/cubit/home_navigation/home_navigation_cubit.dart';
import 'package:vall/home/misc/entity/place.dart';
import 'package:vall/home/misc/navigator/home_navigator.dart';
import 'package:vall/home/places/cubit/places_cubit.dart';
import 'package:vall/home/places/misc/component/place_image.dart';

part 'misc/component/discovered/places_discovered.dart';
part 'misc/component/discovered/places_discovered_others_tab.dart';
part 'misc/component/discovered/places_discovered_tab.dart';
part 'misc/component/discovered/places_in_trip_tab.dart';
part 'misc/component/discovered/places_list_item.dart';
part 'misc/component/places_not_discovered.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocBuilder<PlacesCubit, PlacesState>(
            builder: (context, state) => switch (state) {
              PlacesNotDiscovered() => const _PlacesNotDiscovered(),
              PlacesDiscovered() => _PlacesDiscovered(
                  discoveredPlaces: state.discovered.places,
                  discoveredRestaurants: state.discovered.restaurants,
                  discoveredCafes: state.discovered.cafes,
                  placesInTrip: state.inTrip,
                ),
            },
          ),
        ),
      );
}
