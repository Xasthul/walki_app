part of '../../profile_page.dart';

class _ProfileVisitedPlacesListEmpty extends StatelessWidget {
  const _ProfileVisitedPlacesListEmpty();

  @override
  Widget build(BuildContext context) => const Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Text('You have not yet visited any places '),
          ),
        ),
      );
}
