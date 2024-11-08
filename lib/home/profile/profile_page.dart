import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/component/app_loading_indicator.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/profile/cubit/profile_cubit.dart';
import 'package:vall/home/profile/utils/entity/user.dart';

part 'utils/widget/profile_content.dart';
part 'utils/widget/profile_settings_button.dart';
part 'utils/widget/profile_user_section.dart';
part 'utils/widget/profile_visited_places_list_empty.dart';
part 'utils/widget/profile_visited_places_list_item.dart';
part 'utils/widget/profile_visited_places_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocSelector<ProfileCubit, ProfileState, bool>(
            selector: (state) => state is ProfileLoading,
            builder: (context, isLoading) => Stack(children: [
              const _ProfileContent(),
              if (isLoading) const AppLoadingIndicator(),
            ]),
          ),
        ),
      );
}
