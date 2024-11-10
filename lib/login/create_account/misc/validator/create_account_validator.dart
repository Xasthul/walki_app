import 'package:vall/app/common/constants/app_regexp.dart';
import 'package:vall/login/create_account/misc/validator/create_account_validation.dart';

class CreateAccountValidator {
  CreateAccountValidation validate({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) =>
      CreateAccountValidation(
        nameError: _getNameError(name),
        emailError: _getEmailError(email),
        passwordError: _getPasswordError(password),
        confirmPasswordError: _getConfirmPasswordError(password, confirmPassword),
      );

  CreateAccountNameValidationError _getNameError(String name) {
    if (name.isEmpty) {
      return CreateAccountNameValidationError.empty;
    }
    return CreateAccountNameValidationError.none;
  }

  CreateAccountEmailValidationError _getEmailError(String email) {
    if (email.isEmpty) {
      return CreateAccountEmailValidationError.empty;
    }
    if (!AppRegExp.emailValidationRegExp.hasMatch(email)) {
      return CreateAccountEmailValidationError.invalid;
    }
    return CreateAccountEmailValidationError.none;
  }

  CreateAccountPasswordValidationError _getPasswordError(String password) {
    if (password.isEmpty) {
      return CreateAccountPasswordValidationError.empty;
    }
    if (!AppRegExp.passwordValidationRegExp.hasMatch(password)) {
      return CreateAccountPasswordValidationError.invalid;
    }
    return CreateAccountPasswordValidationError.none;
  }

  CreateAccountConfirmPasswordValidationError _getConfirmPasswordError(
    String password,
    String confirmPassword,
  ) {
    if (confirmPassword.isEmpty) {
      return CreateAccountConfirmPasswordValidationError.empty;
    }
    if (password != confirmPassword) {
      return CreateAccountConfirmPasswordValidationError.invalid;
    }
    return CreateAccountConfirmPasswordValidationError.none;
  }
}
