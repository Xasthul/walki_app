part of '../../create_account_page.dart';

class _CreateAccountConfirmPasswordTextField extends StatefulWidget {
  const _CreateAccountConfirmPasswordTextField();

  @override
  State<_CreateAccountConfirmPasswordTextField> createState() => _CreateAccountConfirmPasswordTextFieldState();
}

class _CreateAccountConfirmPasswordTextFieldState extends State<_CreateAccountConfirmPasswordTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocSelector<CreateAccountValidationCubit, CreateAccountValidationState,
          CreateAccountConfirmPasswordValidationError?>(
        selector: (state) {
          if (state is CreateAccountValidationFailed) {
            return state.validation.confirmPasswordError;
          }
          return null;
        },
        builder: (context, confirmPasswordError) => AppTextField(
          controller: _controller,
          hint: 'Confirm your password',
          onChanged: context.read<CreateAccountValidationCubit>().onConfirmPasswordChanged,
          errorText: _getErrorText(confirmPasswordError),
          obscureText: true,
        ),
      );

  String? _getErrorText(CreateAccountConfirmPasswordValidationError? error) => switch (error) {
        CreateAccountConfirmPasswordValidationError.empty => 'Confirm password field cannot be empty',
        CreateAccountConfirmPasswordValidationError.invalid => 'Passwords do not match',
        _ => null,
      };
}
