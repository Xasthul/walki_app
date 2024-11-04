part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSet extends AuthenticationState {}

class AuthenticationNotSet extends AuthenticationState {}
