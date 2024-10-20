part of 'trip_settings_component.dart';

class _TripSettingsNotch extends StatelessWidget {
  const _TripSettingsNotch();

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: 3,
          width: 64,
          margin: const EdgeInsets.symmetric(vertical: 12),
        ),
      );
}
