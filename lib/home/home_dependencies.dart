import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/cubit/home_cubit.dart';
import 'package:vall/home/places/cubit/places_cubit.dart';
import 'package:vall/home/places/misc/repository/places_repository.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';
import 'package:vall/home/trip/misc/repository/trip_repository.dart';
import 'package:vall/home/trip/misc/service/point_of_interest_service.dart';

class HomeDependencies extends StatelessWidget {
  const HomeDependencies({
    super.key,
    required Widget child,
  }) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => PointOfInterestService()),
          RepositoryProvider(create: (context) => TripRepository()),
          RepositoryProvider(
            create: (context) => PlacesRepository(
              pointOfInterestService: RepositoryProvider.of<PointOfInterestService>(context),
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => HomeCubit()),
            BlocProvider(
              create: (context) => TripCubit(
                tripRepository: RepositoryProvider.of<TripRepository>(context),
                placesRepository: RepositoryProvider.of<PlacesRepository>(context),
              )..load(),
            ),
            BlocProvider(
              lazy: false,
              create: (context) => PlacesCubit(
                placesRepository: RepositoryProvider.of<PlacesRepository>(context),
                tripRepository: RepositoryProvider.of<TripRepository>(context),
              )..load(),
            )
          ],
          child: _child,
        ),
      );
}
