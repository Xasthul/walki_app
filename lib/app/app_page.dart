import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/component/app_loading_page.dart';
import 'package:vall/authentication/cubit/authentication_cubit.dart';
import 'package:vall/home/home_page.dart';
import 'package:vall/login/login_page.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) => switch (state) {
          AuthenticationLoading() => const AppLoadingPage(),
          AuthenticationSet() => const HomePage(),
          AuthenticationNotSet() => const LoginPage(),
        },
      );
}
