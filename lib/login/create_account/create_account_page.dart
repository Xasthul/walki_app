import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/login/create_account/cubit/create_account_cubit.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
            child: Center(
          child: FilledButton(
            onPressed: context.read<CreateAccountCubit>().createAccount,
            child: const Text('Create account'),
          ),
        )),
      );
}
