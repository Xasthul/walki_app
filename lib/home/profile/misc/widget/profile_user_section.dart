part of '../../profile_page.dart';

class _ProfileUserSection extends StatelessWidget {
  const _ProfileUserSection({
    required User user,
  }) : _user = user;

  final User _user;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(children: [
          Text(
            'Hey, ${_user.name}!',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(_user.email),
        ]),
      );
}
