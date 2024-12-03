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
            context.read<LoginValidationCubit>().resetValidationResult();
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
              const SizedBox(height: 16),
              const _LoginPasswordTextField(),
              const SizedBox(height: 32),
              AppFilledButton(
                onPressed: context.read<LoginValidationCubit>().validate,
                label: 'Login',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account yet?"),
                  AppTextButton(
                    onPressed: LoginNavigator.of(context).navigateToCreateAccount,
                    label: 'Create it here',
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
