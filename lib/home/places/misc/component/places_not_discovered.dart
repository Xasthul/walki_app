part of '../../places_page.dart';

class _PlacesNotDiscovered extends StatelessWidget {
  const _PlacesNotDiscovered();

  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('No places found yet'),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: context.read<HomeNavigationCubit>().openTripPage,
            child: const Text('Go to places discovery'),
          ),
        ]),
      );
}
