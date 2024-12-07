import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/network/dio_client.dart';
import 'package:vall/app/common/network/dio_client_factory.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';
import 'package:vall/home/cubit/home_navigation/home_navigation_cubit.dart';
import 'package:vall/home/cubit/location_permission/location_permission_cubit.dart';
import 'package:vall/home/misc/mapper/place_mapper.dart';
import 'package:vall/home/misc/repository/current_location_repository.dart';
import 'package:vall/home/misc/repository/places_repository.dart';
import 'package:vall/home/misc/repository/trip_repository.dart';
import 'package:vall/home/misc/service/google_api_service.dart';
import 'package:vall/home/places/cubit/places_cubit.dart';
import 'package:vall/home/profile/cubit/profile_cubit.dart';
import 'package:vall/home/profile/misc/repository/user_repository.dart';
import 'package:vall/home/profile/misc/repository/visited_places_repository.dart';
import 'package:vall/home/profile/misc/service/user_service.dart';
import 'package:vall/home/profile/misc/service/visited_places_service.dart';
import 'package:vall/home/trip/cubit/current_location/current_location_cubit.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';
import 'package:vall/home/trip/visit_place/cubit/trip_visit_place_cubit.dart';
import 'package:vall/home/trip/visit_place/misc/mapper/visited_place_mapper.dart';
import 'package:vall/home/trip/visit_place/misc/repository/trip_visit_place_repository.dart';

class HomeDependencies extends StatelessWidget {
  const HomeDependencies({
    super.key,
    required Widget child,
  }) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<GoogleApiDioClient>(
            create: (context) => DioClientFactory.createGoogleApiDioClient(),
          ),
          RepositoryProvider<GoogleApiService>(
            create: (context) => GoogleApiService(
              client: context.read<GoogleApiDioClient>(),
            ),
          ),
          RepositoryProvider<UserService>(
            create: (context) => UserService(
              client: context.read<AuthorizedDioClient>(),
            ),
          ),
          RepositoryProvider<VisitedPlacesService>(
            create: (context) => VisitedPlacesService(
              client: context.read<AuthorizedDioClient>(),
            ),
          ),
          RepositoryProvider<TripRepository>(create: (context) => TripRepository()),
          RepositoryProvider<PlaceMapper>(create: (context) => PlaceMapper()),
          RepositoryProvider<PlacesRepository>(
            create: (context) => PlacesRepository(
              googleApiService: context.read<GoogleApiService>(),
              pointOfInterestMapper: context.read<PlaceMapper>(),
            ),
          ),
          RepositoryProvider<CurrentLocationRepository>(create: (context) => CurrentLocationRepository()),
          RepositoryProvider<UserRepository>(
            create: (context) => UserRepository(
              userService: context.read<UserService>(),
            ),
          ),
          RepositoryProvider<VisitedPlaceMapper>(create: (context) => VisitedPlaceMapper()),
          RepositoryProvider<VisitedPlacesRepository>(
            create: (context) => VisitedPlacesRepository(
              visitedPlacesService: context.read<VisitedPlacesService>(),
              visitedPlaceMapper: context.read<VisitedPlaceMapper>(),
            ),
          ),
          RepositoryProvider<TripVisitPlaceRepository>(
            create: (context) => TripVisitPlaceRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeNavigationCubit>(
              create: (context) => HomeNavigationCubit(),
            ),
            BlocProvider<LocationPermissionCubit>(
              create: (context) => LocationPermissionCubit()..load(),
            ),
            BlocProvider<CurrentLocationCubit>(
              create: (context) => CurrentLocationCubit(
                currentLocationRepository: context.read<CurrentLocationRepository>(),
              )..load(),
            ),
            BlocProvider<TripCubit>(
              create: (context) => TripCubit(
                currentLocationRepository: context.read<CurrentLocationRepository>(),
                tripRepository: context.read<TripRepository>(),
                placesRepository: context.read<PlacesRepository>(),
              )..load(),
            ),
            BlocProvider<TripVisitPlaceCubit>(
              create: (context) => TripVisitPlaceCubit(
                currentLocationRepository: context.read<CurrentLocationRepository>(),
                visitedPlacesRepository: context.read<VisitedPlacesRepository>(),
                tripVisitPlaceRepository: context.read<TripVisitPlaceRepository>(),
                visitedPlaceMapper: context.read<VisitedPlaceMapper>(),
              )..load(),
            ),
            BlocProvider<PlacesCubit>(
              create: (context) => PlacesCubit(
                placesRepository: context.read<PlacesRepository>(),
                tripRepository: context.read<TripRepository>(),
              )..load(),
            ),
            BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit(
                authenticationRepository: context.read<AuthenticationRepository>(),
                userRepository: context.read<UserRepository>(),
                visitedPlacesRepository: context.read<VisitedPlacesRepository>(),
              )..load(),
            ),
          ],
          child: _child,
        ),
      );
}
