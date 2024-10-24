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
              child: FilledButton(
                onPressed: context.read<TripCubit>().closePlaceSelection,
                child: const Text('Close'),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FilledButton(
              onPressed: _onPlaceSelected,
              child: const Text('Select place'),
            ),
          ),
        )
      ]);
}
