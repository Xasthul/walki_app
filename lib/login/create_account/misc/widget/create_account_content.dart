part of '../../create_account_page.dart';

class _CreateAccountContent extends StatelessWidget {
  const _CreateAccountContent();

  @override
  Widget build(BuildContext context) => BlocListener<CreateAccountValidationCubit, CreateAccountValidationState>(
        listener: (context, state) {
          if (state is CreateAccountValidationSucceeded) {
            context.read<CreateAccountCubit>().createAccount(
                  name: state.name,
                  email: state.email,
                  password: state.password,
                );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 24),
                const _CreateAccountNameTextField(),
                const SizedBox(height: 24),
                const _CreateAccountEmailTextField(),
                const SizedBox(height: 24),
                const _CreateAccountPasswordTextField(),
                const SizedBox(height: 24),
                const _CreateAccountConfirmPasswordTextField(),
                const SizedBox(height: 24),
                AppFilledButton(
                  onPressed: context.read<CreateAccountValidationCubit>().validate,
                  label: 'Submit',
                ),
              ],
            ),
          ),
        ),
      );
}
