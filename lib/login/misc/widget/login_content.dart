part of '../../login_page.dart';

class _LoginContent extends StatelessWidget {
  const _LoginContent();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Login'),
        const _LoginEmailTextField(),
        const _LoginPasswordTextField(),
        FilledButton(
          onPressed: context.read<LoginCubit>().login,
          child: const Text('Login'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account yet?"),
            TextButton(
              onPressed: LoginNavigator.of(context).navigateToCreateAccount,
              child: const Text('Create it here'),
            ),
          ],
        ),
      ],
    ),
  );
}
