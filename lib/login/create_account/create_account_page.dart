import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/widget/app_filled_button.dart';
import 'package:vall/app/common/widget/app_loading_cover.dart';
import 'package:vall/app/common/widget/app_snack_bar.dart';
import 'package:vall/app/common/widget/app_text_field.dart';
import 'package:vall/app/common/widget/keyboard_dismisser.dart';
import 'package:vall/login/create_account/cubit/create_account_cubit.dart';
import 'package:vall/login/create_account/cubit/validation/create_account_validation_cubit.dart';
import 'package:vall/login/create_account/misc/validator/create_account_validation.dart';
import 'package:vall/login/cubit/login_cubit.dart';
import 'package:vall/login/misc/navigator/login_navigator.dart';

part 'misc/widget/create_account_content.dart';
part 'misc/widget/create_account_name_text_field.dart';
part 'misc/widget/create_account_email_text_field.dart';
part 'misc/widget/create_account_password_text_field.dart';
part 'misc/widget/create_account_confirm_password_text_field.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Create account'),
            leading: IconButton(
              onPressed: LoginNavigator.of(context).pop,
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          body: SafeArea(
            child: BlocConsumer<CreateAccountCubit, CreateAccountState>(
              listener: (context, state) {
                if (state is CreateAccountFailed) {
                  ScaffoldMessenger.of(context).showErrorSnackBar(text: state.errorMessage);
                  return;
                }
                if (state is CreateAccountSucceeded) {
                  LoginNavigator.of(context).pop();
                  context.read<LoginCubit>().login(
                        email: state.email,
                        password: state.password,
                      );
                }
              },
              builder: (context, state) => Stack(children: [
                const _CreateAccountContent(),
                if (state is CreateAccountLoading) const AppLoadingCover(),
              ]),
            ),
          ),
        ),
      );
}
