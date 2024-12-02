part of 'trip_settings_component.dart';

class _TripSettingsContent extends StatelessWidget {
  const _TripSettingsContent({
    required VoidCallback collapseSettings,
  }) : _collapseSettings = collapseSettings;

  final VoidCallback _collapseSettings;

  @override
  Widget build(BuildContext context) => Column(children: [
        const _TripSettingsSearchRadius(),
        const SizedBox(height: 8),
        const _TripSettingsTravelMode(),
        const SizedBox(height: 8),
        const _TripSettingsFindPlaces(),
        const SizedBox(height: 32),
        _TripSettingsYourTrip(collapseSettings: _collapseSettings),
        const SizedBox(height: 8),
      ]);
}
