import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/network/dio_client.dart';
import 'package:vall/app/common/network/dio_client_factory.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';
import 'package:vall/home/cubit/home_navigation/home_navigation_cubit.dart';
import 'package:vall/home/cubit/location_permission/location_permission_cubit.dart';
import 'package:vall/home/misc/mapper/point_of_interest_mapper.dart';
import 'package:vall/home/misc/repository/current_location_repository.dart';
import 'package:vall/home/misc/repository/places_repository.dart';
import 'package:vall/home/misc/repository/trip_repository.dart';
import 'package:vall/home/misc/service/google_api_service.dart';
import 'package:vall/home/places/cubit/places_cubit.dart';
import 'package:vall/home/profile/cubit/profile_cubit.dart';
import 'package:vall/home/profile/utils/network/user_service.dart';
import 'package:vall/home/profile/utils/repository/user_repository.dart';
import 'package:vall/home/trip/cubit/initial_location/initial_location_cubit.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';

class HomeDependencies extends StatelessWidget {
  const HomeDependencies({
    super.key,
    required Widget child,
  }) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => DioClientFactory.createGoogleApiDioClient(),
          ),
          RepositoryProvider(
            create: (context) => GoogleApiService(
              client: context.read<GoogleApiDioClient>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => UserService(
              client: context.read<AuthorizedDioClient>(),
            ),
          ),
          RepositoryProvider(create: (context) => TripRepository()),
          RepositoryProvider(create: (context) => PointOfInterestMapper()),
          RepositoryProvider(
            create: (context) => PlacesRepository(
              googleApiService: context.read<GoogleApiService>(),
              pointOfInterestMapper: context.read<PointOfInterestMapper>(),
            ),
          ),
          RepositoryProvider(create: (context) => CurrentLocationRepository()),
          RepositoryProvider(
            create: (context) => UserRepository(
              userService: context.read<UserService>(),
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HomeNavigationCubit(),
            ),
            BlocProvider(
              create: (context) => LocationPermissionCubit()..load(),
            ),
            BlocProvider(
              create: (context) => InitialLocationCubit(
                currentLocationRepository: context.read<CurrentLocationRepository>(),
              )..load(),
            ),
            BlocProvider(
              create: (context) => TripCubit(
                currentLocationRepository: context.read<CurrentLocationRepository>(),
                tripRepository: context.read<TripRepository>(),
                placesRepository: context.read<PlacesRepository>(),
              )..load(),
            ),
            BlocProvider(
              create: (context) => PlacesCubit(
                placesRepository: context.read<PlacesRepository>(),
                tripRepository: context.read<TripRepository>(),
              )..load(),
            ),
            BlocProvider(
              create: (context) => ProfileCubit(
                authenticationRepository: context.read<AuthenticationRepository>(),
                userRepository: context.read<UserRepository>(),
              )..load(),
            ),
          ],
          child: _child,
        ),
      );
}
