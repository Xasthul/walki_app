import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';
import 'package:vall/login/create_account/cubit/create_account_cubit.dart';
import 'package:vall/login/cubit/login_cubit.dart';

class LoginDependencies extends StatelessWidget {
  const LoginDependencies({
    super.key,
    required Widget child,
  }) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(
              authenticationRepository: context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider<CreateAccountCubit>(
            create: (context) => CreateAccountCubit(
              authenticationRepository: context.read<AuthenticationRepository>(),
            ),
          ),
        ],
        child: _child,
      );
}
