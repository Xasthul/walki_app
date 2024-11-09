part of 'login_validation_cubit.dart';

sealed class LoginValidationState extends Equatable {
  const LoginValidationState({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class LoginValidationInitial extends LoginValidationState {
  const LoginValidationInitial() : super(email: '', password: '');
}

class LoginValidationUpdated extends LoginValidationState {
  const LoginValidationUpdated({
    required super.email,
    required super.password,
  });
}

class LoginValidationSucceeded extends LoginValidationState {
  LoginValidationSucceeded(LoginValidationState currentState)
      : super(
          email: currentState.email,
          password: currentState.password,
        );
}

class LoginValidationFailed extends LoginValidationState {
  LoginValidationFailed(LoginValidationState currentState, {required this.validation})
      : super(
          email: currentState.email,
          password: currentState.password,
        );

  final LoginValidation validation;

  @override
  List<Object?> get props => super.props..add(validation);
}
