part of '../../login_page.dart';

class _LoginContent extends StatelessWidget {
  const _LoginContent();

  @override
  Widget build(BuildContext context) => BlocListener<LoginValidationCubit, LoginValidationState>(
        listener: (context, state) {
          if (state is LoginValidationSucceeded) {
            context.read<LoginCubit>().login(
                  email: state.email,
                  password: state.password,
                );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login', style: TextStyle(fontSize: 36)),
              const SizedBox(height: 36),
              const _LoginEmailTextField(),
              const SizedBox(height: 24),
              const _LoginPasswordTextField(),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: context.read<LoginValidationCubit>().validate,
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
        ),
      );
}
