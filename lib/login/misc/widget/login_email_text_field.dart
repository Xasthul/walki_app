part of '../../login_page.dart';

class _LoginEmailTextField extends StatefulWidget {
  const _LoginEmailTextField();

  @override
  State<_LoginEmailTextField> createState() => _LoginEmailTextFieldState();
}

class _LoginEmailTextFieldState extends State<_LoginEmailTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      BlocSelector<LoginValidationCubit, LoginValidationState, LoginEmailValidationError?>(
        selector: (state) {
          if (state is LoginValidationFailed) {
            return state.validation.emailError;
          }
          return null;
        },
        builder: (context, emailError) => AppTextField(
          controller: _controller,
          hint: 'Enter your email',
          onChanged: context.read<LoginValidationCubit>().onEmailChanged,
          errorText: _getErrorText(emailError),
        ),
      );

  String? _getErrorText(LoginEmailValidationError? error) => switch (error) {
        LoginEmailValidationError.empty => 'Email field cannot be empty',
        _ => null,
      };
}
