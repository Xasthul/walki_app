import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/trip/common/use_case/trip_use_case.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';

class TripDependencies extends StatelessWidget {
  const TripDependencies({
    super.key,
    required Widget child,
  }) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => TripCubit(
          tripUseCase: RepositoryProvider.of<TripUseCase>(context),
        ),
        child: _child,
      );
}
