import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/theme/app_colors.dart';
import 'package:vall/app/common/widget/app_filled_button.dart';
import 'package:vall/home/misc/navigator/home_navigator.dart';
import 'package:vall/home/profile/cubit/profile_cubit.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          leading: IconButton(
            onPressed: HomeNavigator.of(context).pop,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppFilledButton(
                    onPressed: context.read<ProfileCubit>().logOut,
                    label: 'Logout',
                  ),
                  const SizedBox(height: 16),
                  AppFilledButton(
                    onPressed: context.read<ProfileCubit>().deleteAccount,
                    label: 'Delete account',
                    backgroundColor: AppColors.error300,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
