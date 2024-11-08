part of '../../profile_page.dart';

class _ProfileUserSection extends StatelessWidget {
  const _ProfileUserSection({
    required User user,
  }) : _user = user;

  final User _user;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(children: [
          Text(_user.name),
          const SizedBox(height: 8),
          Text(_user.email),
        ]),
  );
}
