part of '../../create_account_page.dart';

class _CreateAccountPasswordTextField extends StatefulWidget {
  const _CreateAccountPasswordTextField();

  @override
  State<_CreateAccountPasswordTextField> createState() => _CreateAccountPasswordTextFieldState();
}

class _CreateAccountPasswordTextFieldState extends State<_CreateAccountPasswordTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      BlocSelector<CreateAccountValidationCubit, CreateAccountValidationState, CreateAccountPasswordValidationError?>(
        selector: (state) {
          if (state is CreateAccountValidationFailed) {
            return state.validation.passwordError;
          }
          return null;
        },
        builder: (context, passwordError) => AppTextField(
          controller: _controller,
          hint: 'Enter your password',
          onChanged: context.read<CreateAccountValidationCubit>().onPasswordChanged,
          errorText: _getErrorText(passwordError),
          obscureText: true,
        ),
      );

  String? _getErrorText(CreateAccountPasswordValidationError? error) => switch (error) {
        CreateAccountPasswordValidationError.empty => 'Password field cannot be empty',
        CreateAccountPasswordValidationError.invalid => 'Password must be at least 12 characters, contain an uppercase and a lowercase letter, a digit, and a special character',
        _ => null,
      };
}
