part of '../../create_account_page.dart';

class _CreateAccountEmailTextField extends StatefulWidget {
  const _CreateAccountEmailTextField();

  @override
  State<_CreateAccountEmailTextField> createState() => _CreateAccountEmailTextFieldState();
}

class _CreateAccountEmailTextFieldState extends State<_CreateAccountEmailTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      BlocSelector<CreateAccountValidationCubit, CreateAccountValidationState, CreateAccountEmailValidationError?>(
        selector: (state) {
          if (state is CreateAccountValidationFailed) {
            return state.validation.emailError;
          }
          return null;
        },
        builder: (context, emailError) => AppTextField(
          controller: _controller,
          hint: 'Enter your email',
          onChanged: context.read<CreateAccountValidationCubit>().onEmailChanged,
          errorText: _getErrorText(emailError),
        ),
      );

  String? _getErrorText(CreateAccountEmailValidationError? error) => switch (error) {
        CreateAccountEmailValidationError.empty => 'Email field cannot be empty',
        CreateAccountEmailValidationError.invalid => 'Enter a valid email',
        _ => null,
      };
}
