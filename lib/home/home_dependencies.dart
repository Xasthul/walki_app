import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/cubit/location_permission/location_permission_cubit.dart';
import 'package:vall/home/places/cubit/places_cubit.dart';
import 'package:vall/home/places/misc/repository/places_repository.dart';
import 'package:vall/home/trip/cubit/initial_location/initial_location_cubit.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';
import 'package:vall/home/trip/misc/mapper/trip_mapper.dart';
import 'package:vall/home/trip/misc/repository/trip_repository.dart';
import 'package:vall/home/trip/misc/service/point_of_interest_service.dart';
import 'package:vall/home/trip/misc/use_case/current_location_use_case.dart';
import 'package:vall/home/trip/misc/use_case/trip_use_case.dart';

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
              pointOfInterestService: context.read<PointOfInterestService>(),
            ),
          ),
          RepositoryProvider(create: (context) => TripUseCase()),
          RepositoryProvider(create: (context) => CurrentLocationUseCase()),
          RepositoryProvider(create: (context) => TripMapper()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LocationPermissionCubit()..load(),
            ),
            BlocProvider(
              create: (context) => InitialLocationCubit(
                currentLocationUseCase: context.read<CurrentLocationUseCase>(),
              )..load(),
            ),
            BlocProvider(
              create: (context) => TripCubit(
                tripUseCase: context.read<TripUseCase>(),
                currentLocationUseCase: context.read<CurrentLocationUseCase>(),
                tripRepository: context.read<TripRepository>(),
                placesRepository: context.read<PlacesRepository>(),
                tripMapper: context.read<TripMapper>(),
              )..load(),
            ),
            BlocProvider(
              lazy: false,
              create: (context) => PlacesCubit(
                placesRepository: context.read<PlacesRepository>(),
                tripRepository: context.read<TripRepository>(),
              )..load(),
            )
          ],
          child: _child,
        ),
      );
}
