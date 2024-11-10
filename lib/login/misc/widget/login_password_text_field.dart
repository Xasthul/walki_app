part of '../../login_page.dart';

class _LoginPasswordTextField extends StatefulWidget {
  const _LoginPasswordTextField();

  @override
  State<_LoginPasswordTextField> createState() => _LoginPasswordTextFieldState();
}

class _LoginPasswordTextFieldState extends State<_LoginPasswordTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      BlocSelector<LoginValidationCubit, LoginValidationState, LoginPasswordValidationError?>(
        selector: (state) {
          if (state is LoginValidationFailed) {
            return state.validation.passwordError;
          }
          return null;
        },
        builder: (context, passwordError) => AppTextField(
          controller: _controller,
          hint: 'Enter your password',
          onChanged: context.read<LoginValidationCubit>().onPasswordChanged,
          errorText: _getErrorText(passwordError),
          obscureText: true,
        ),
      );

  String? _getErrorText(LoginPasswordValidationError? error) => switch (error) {
        LoginPasswordValidationError.empty => 'Password field cannot be empty',
        _ => null,
      };
}
