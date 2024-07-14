import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/cubit/home_cubit.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';
import 'package:vall/home/trip/utils/service/point_of_interest_service.dart';
import 'package:vall/home/trip/utils/use_case/trip_repository.dart';

class AppDependencies extends StatelessWidget {
  const AppDependencies({
    super.key,
    required Widget child,
  }) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => PointOfInterestService()),
          RepositoryProvider(
            create: (context) => TripRepository(
              pointOfInterestService: RepositoryProvider.of<PointOfInterestService>(context),
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => HomeCubit()..init()),
            BlocProvider(
              create: (context) => TripCubit(
                tripRepository: RepositoryProvider.of<TripRepository>(context),
              )..init(),
            ),
          ],
          child: _child,
        ),
      );
}
