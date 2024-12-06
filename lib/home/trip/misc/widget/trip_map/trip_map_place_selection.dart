part of 'trip_map_component.dart';

class _TripMapPlaceSelection extends StatelessWidget {
  const _TripMapPlaceSelection({
    required VoidCallback onPlaceSelected,
  }) : _onPlaceSelected = onPlaceSelected;

  final VoidCallback _onPlaceSelected;

  @override
  Widget build(BuildContext context) => Stack(children: [
        const Align(
          child: Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: AppFilledButton(
                onPressed: context.read<TripCubit>().closePlaceSelection,
                label: 'Close',
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppFilledButton(
              onPressed: _onPlaceSelected,
              label: 'Select place',
            ),
          ),
        )
      ]);
}
