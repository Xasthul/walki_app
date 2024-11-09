import 'package:equatable/equatable.dart';

class LoginValidation extends Equatable {
  const LoginValidation({
    required this.emailError,
    required this.passwordError,
  });

  final LoginEmailValidationError emailError;
  final LoginPasswordValidationError passwordError;

  bool get isValid =>
      emailError == LoginEmailValidationError.none && passwordError == LoginPasswordValidationError.none;

  @override
  List<Object> get props => [emailError, passwordError];
}

enum LoginEmailValidationError { none, empty }

enum LoginPasswordValidationError { none, empty }
