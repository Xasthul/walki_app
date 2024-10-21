part of '../trip_settings_component.dart';

class _TripSettingsTravelModeChip extends StatelessWidget {
  const _TripSettingsTravelModeChip({
    required String label,
    required TripTravelMode travelMode,
    required TripTravelMode selectedTravelMode,
    required Function(TripTravelMode) onSelected,
  })  : _label = label,
        _travelMode = travelMode,
        _selectedTravelMode = selectedTravelMode,
        _onSelected = onSelected;

  final String _label;
  final TripTravelMode _travelMode;
  final TripTravelMode _selectedTravelMode;
  final Function(TripTravelMode) _onSelected;

  @override
  Widget build(BuildContext context) => ChoiceChip(
        label: Text(_label),
        selected: _travelMode == _selectedTravelMode,
        onSelected: (_) => _onSelected(_travelMode),
        showCheckmark: false,
      );
}
