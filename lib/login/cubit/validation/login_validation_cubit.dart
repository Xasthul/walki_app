import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/login/misc/validator/login_validation.dart';
import 'package:vall/login/misc/validator/login_validator.dart';

part 'login_validation_state.dart';

class LoginValidationCubit extends Cubit<LoginValidationState> {
  LoginValidationCubit({
    required LoginValidator loginValidator,
  })  : _loginValidator = loginValidator,
        super(const LoginValidationInitial());

  final LoginValidator _loginValidator;

  void onEmailChanged(String email) => emit(LoginValidationUpdated(
        email: email,
        password: state.password,
      ));

  void onPasswordChanged(String password) => emit(LoginValidationUpdated(
        email: state.email,
        password: password,
      ));

  void validate() {
    final validation = _loginValidator.validate(email: state.email, password: state.password);
    if (!validation.isValid) {
      return emit(LoginValidationFailed(state, validation: validation));
    }
    emit(LoginValidationSucceeded(state));
  }

  void resetValidationResult() => emit(LoginValidationUpdated(
        email: state.email,
        password: state.password,
      ));
}
