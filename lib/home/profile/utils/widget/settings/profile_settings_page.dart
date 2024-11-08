import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                children: [
                  const SizedBox(height: 48),
                  FilledButton(
                    onPressed: context.read<ProfileCubit>().logOut,
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
