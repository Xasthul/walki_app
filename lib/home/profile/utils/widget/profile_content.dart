part of '../../profile_page.dart';

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) => Column(children: [
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.all(8),
            child: const _ProfileSettingsButton(),
          ),
          if (state.user != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _ProfileUserSection(user: state.user!),
            ),
        ]),
      );
}
