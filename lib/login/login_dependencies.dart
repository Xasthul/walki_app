import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';
import 'package:vall/login/create_account/cubit/create_account_cubit.dart';
import 'package:vall/login/create_account/cubit/validation/create_account_validation_cubit.dart';
import 'package:vall/login/create_account/misc/validator/create_account_validator.dart';
import 'package:vall/login/cubit/login_cubit.dart';
import 'package:vall/login/cubit/validation/login_validation_cubit.dart';
import 'package:vall/login/misc/validator/login_validator.dart';

class LoginDependencies extends StatelessWidget {
  const LoginDependencies({
    super.key,
    required Widget child,
  }) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<LoginValidator>(
            create: (context) => LoginValidator(),
          ),
          RepositoryProvider<CreateAccountValidator>(
            create: (context) => CreateAccountValidator(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<LoginCubit>(
              create: (context) => LoginCubit(
                authenticationRepository: context.read<AuthenticationRepository>(),
              ),
            ),
            BlocProvider<LoginValidationCubit>(
              create: (context) => LoginValidationCubit(
                loginValidator: context.read<LoginValidator>(),
              ),
            ),
            BlocProvider<CreateAccountCubit>(
              create: (context) => CreateAccountCubit(
                authenticationRepository: context.read<AuthenticationRepository>(),
              ),
            ),
            BlocProvider<CreateAccountValidationCubit>(
              create: (context) => CreateAccountValidationCubit(
                createAccountValidator: context.read<CreateAccountValidator>(),
              ),
            ),
          ],
          child: _child,
        ),
      );
}
