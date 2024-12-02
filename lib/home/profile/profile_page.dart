import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/widget/app_loading_cover.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/misc/navigator/home_navigator.dart';
import 'package:vall/home/profile/cubit/profile_cubit.dart';
import 'package:vall/home/profile/misc/entity/user.dart';

part 'misc/widget/profile_content.dart';

part 'misc/widget/profile_settings_button.dart';

part 'misc/widget/profile_user_section.dart';

part 'misc/widget/profile_visited_places_list_empty.dart';

part 'misc/widget/profile_visited_places_list_item.dart';

part 'misc/widget/profile_visited_places_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocSelector<ProfileCubit, ProfileState, bool>(
            selector: (state) => state is ProfileLoading,
            builder: (context, isLoading) => Stack(children: [
              const _ProfileContent(),
              if (isLoading) const AppLoadingCover(),
            ]),
          ),
        ),
      );
}
