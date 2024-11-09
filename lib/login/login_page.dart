import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/login/cubit/login_cubit.dart';
import 'package:vall/login/login_dependencies.dart';
import 'package:vall/login/misc/navigator/login_navigator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => LoginDependencies(
        child: LoginNavigator(child: const _LoginPageBase()),
      );
}

class _LoginPageBase extends StatelessWidget {
  const _LoginPageBase();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: context.read<LoginCubit>().login,
                child: const Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account yet?"),
                  TextButton(
                    onPressed: LoginNavigator.of(context).navigateToCreateAccount,
                    child: const Text('Create it here'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
