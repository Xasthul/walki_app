import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/widget/app_loading_indicator.dart';
import 'package:vall/app/common/widget/app_snack_bar.dart';
import 'package:vall/app/common/widget/app_text_field.dart';
import 'package:vall/login/cubit/login_cubit.dart';
import 'package:vall/login/cubit/validation/login_validation_cubit.dart';
import 'package:vall/login/login_dependencies.dart';
import 'package:vall/login/misc/navigator/login_navigator.dart';
import 'package:vall/login/misc/validator/login_validation.dart';

part 'misc/widget/login_content.dart';

part 'misc/widget/login_email_text_field.dart';

part 'misc/widget/login_password_text_field.dart';

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
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginFailed) {
                ScaffoldMessenger.of(context).showErrorSnackBar(text: state.errorMessage);
              }
            },
            builder: (context, state) => Stack(children: [
              const _LoginContent(),
              if (state is LoginLoading) const AppLoadingIndicator(),
            ]),
          ),
        ),
      );
}
