part of 'trip_settings_component.dart';

class _TripSettingsSearchRadius extends StatelessWidget {
  const _TripSettingsSearchRadius();

  static const double _minSearchRadius = 500;
  static const double _maxSearchRadius = 2500;

  @override
  Widget build(BuildContext context) => BlocSelector<TripCubit, TripState, double>(
        selector: (state) => state.settings.searchRadius,
        builder: (context, searchRadius) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Search radius: ${searchRadius.toStringAsFixed(0)}m'),
            const SizedBox(height: 4),
            Slider(
              value: searchRadius,
              min: _minSearchRadius,
              max: _maxSearchRadius,
              onChanged: context.read<TripCubit>().updateSearchRadius,
              activeColor: AppColors.primary300,
              inactiveColor: AppColors.primary100,
            ),
          ],
        ),
      );
}
