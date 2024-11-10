part of 'create_account_cubit.dart';

sealed class CreateAccountState extends Equatable {
  const CreateAccountState();

  @override
  List<Object?> get props => [];
}

class CreateAccountInitial extends CreateAccountState {}

class CreateAccountLoading extends CreateAccountState {}

class CreateAccountSucceeded extends CreateAccountState {
  const CreateAccountSucceeded({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => super.props..addAll([email, password]);
}

class CreateAccountFailed extends CreateAccountState {
  const CreateAccountFailed({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => super.props..add(errorMessage);
}
