part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  LoginState copyWith({
    String? email,
    String? password,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object?> get props => [email, password];
}

class LoginInitial extends LoginState {
  const LoginInitial() : super(email: '', password: '');
}

class LoginLoading extends LoginState {
  LoginLoading(LoginState currentState)
      : super(
          email: currentState.email,
          password: currentState.password,
        );
}

class LoginFailed extends LoginState {
  LoginFailed(LoginState currentState, {required this.errorMessage})
      : super(
          email: currentState.email,
          password: currentState.password,
        );

  final String errorMessage;

  @override
  List<Object?> get props => super.props..add(errorMessage);
}
