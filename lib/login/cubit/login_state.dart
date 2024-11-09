part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginFailed extends LoginState {
  const LoginFailed({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => super.props..add(errorMessage);
}
