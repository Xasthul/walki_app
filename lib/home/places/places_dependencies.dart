import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/places/cubit/places_cubit.dart';
import 'package:vall/home/trip/common/use_case/trip_use_case.dart';

class PlacesDependencies extends StatelessWidget {
  const PlacesDependencies({
    super.key,
    required Widget child,
  }) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => PlacesCubit(tripUseCase: RepositoryProvider.of<TripUseCase>(context)),
        child: _child,
      );
}
