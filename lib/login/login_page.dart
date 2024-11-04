import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/login/cubit/login_cubit.dart';
import 'package:vall/login/login_dependencies.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => const LoginDependencies(
        child: _LoginPageBase(),
      );
}

class _LoginPageBase extends StatelessWidget {
  const _LoginPageBase();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: FilledButton(
            onPressed: context.read<LoginCubit>().login,
            child: const Text('Login'),
          ),
        ),
      );
}
