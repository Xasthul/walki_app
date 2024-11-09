part of '../../profile_page.dart';

class _ProfileSettingsButton extends StatelessWidget {
  const _ProfileSettingsButton();

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: HomeNavigator.of(context).navigateToProfileSettings,
        icon: const Icon(Icons.settings_rounded),
      );
}
