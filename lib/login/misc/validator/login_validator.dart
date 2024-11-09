import 'package:vall/login/misc/validator/login_validation.dart';

class LoginValidator {
  LoginValidation validate({required String email, required String password}) => LoginValidation(
        emailError: _getEmailError(email),
        passwordError: _getPasswordError(password),
      );

  LoginEmailValidationError _getEmailError(String email) {
    if (email.isEmpty) {
      return LoginEmailValidationError.empty;
    }
    return LoginEmailValidationError.none;
  }

  LoginPasswordValidationError _getPasswordError(String password) {
    if (password.isEmpty) {
      return LoginPasswordValidationError.empty;
    }
    return LoginPasswordValidationError.none;
  }
}
