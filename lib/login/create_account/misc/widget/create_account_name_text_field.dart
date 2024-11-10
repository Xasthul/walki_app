part of '../../create_account_page.dart';

class _CreateAccountNameTextField extends StatefulWidget {
  const _CreateAccountNameTextField();

  @override
  State<_CreateAccountNameTextField> createState() => _CreateAccountNameTextFieldState();
}

class _CreateAccountNameTextFieldState extends State<_CreateAccountNameTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      BlocSelector<CreateAccountValidationCubit, CreateAccountValidationState, CreateAccountNameValidationError?>(
        selector: (state) {
          if (state is CreateAccountValidationFailed) {
            return state.validation.nameError;
          }
          return null;
        },
        builder: (context, nameError) => AppTextField(
          controller: _controller,
          hint: 'Enter your name',
          onChanged: context.read<CreateAccountValidationCubit>().onNameChanged,
          errorText: _getErrorText(nameError),
        ),
      );

  String? _getErrorText(CreateAccountNameValidationError? error) => switch (error) {
        CreateAccountNameValidationError.empty => 'Name field cannot be empty',
        _ => null,
      };
}
