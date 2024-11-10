import 'package:equatable/equatable.dart';

class CreateAccountValidation extends Equatable {
  const CreateAccountValidation({
    required this.nameError,
    required this.emailError,
    required this.confirmPasswordError,
    required this.passwordError,
  });

  final CreateAccountNameValidationError nameError;
  final CreateAccountEmailValidationError emailError;
  final CreateAccountPasswordValidationError passwordError;
  final CreateAccountConfirmPasswordValidationError confirmPasswordError;

  bool get isValid =>
      nameError == CreateAccountNameValidationError.none &&
      emailError == CreateAccountEmailValidationError.none &&
      passwordError == CreateAccountPasswordValidationError.none &&
      confirmPasswordError == CreateAccountConfirmPasswordValidationError.none;

  @override
  List<Object> get props => [
        nameError,
        emailError,
        passwordError,
        confirmPasswordError,
      ];
}

enum CreateAccountNameValidationError { none, empty }

enum CreateAccountEmailValidationError { none, empty, invalid }

enum CreateAccountPasswordValidationError { none, empty, invalid }

enum CreateAccountConfirmPasswordValidationError { none, empty, invalid }
