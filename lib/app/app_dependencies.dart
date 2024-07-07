import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/cubit/home_cubit.dart';

class AppDependencies extends StatelessWidget {
  const AppDependencies({
    super.key,
    required Widget child,
  }) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => HomeCubit()..init(),
        child: _child,
      );
}
