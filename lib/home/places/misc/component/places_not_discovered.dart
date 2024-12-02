part of '../../places_page.dart';

class _PlacesNotDiscovered extends StatelessWidget {
  const _PlacesNotDiscovered();

  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'No places found yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          AppFilledButton(
            onPressed: context.read<HomeNavigationCubit>().openTripPage,
            label: 'Go to places discovery',
          ),
        ]),
      );
}
