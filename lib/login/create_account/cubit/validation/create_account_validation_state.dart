part of 'create_account_validation_cubit.dart';

sealed class CreateAccountValidationState extends Equatable {
  const CreateAccountValidationState({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        confirmPassword,
      ];
}

class CreateAccountValidationInitial extends CreateAccountValidationState {
  const CreateAccountValidationInitial()
      : super(
          name: '',
          email: '',
          password: '',
          confirmPassword: '',
        );
}

class CreateAccountValidationUpdated extends CreateAccountValidationState {
  const CreateAccountValidationUpdated({
    required super.name,
    required super.email,
    required super.password,
    required super.confirmPassword,
  });
}

class CreateAccountValidationSucceeded extends CreateAccountValidationState {
  CreateAccountValidationSucceeded(CreateAccountValidationState currentState)
      : super(
          name: currentState.name,
          email: currentState.email,
          password: currentState.password,
          confirmPassword: currentState.confirmPassword,
        );
}

class CreateAccountValidationFailed extends CreateAccountValidationState {
  CreateAccountValidationFailed(CreateAccountValidationState currentState, {required this.validation})
      : super(
          name: currentState.name,
          email: currentState.email,
          password: currentState.password,
          confirmPassword: currentState.confirmPassword,
        );

  final CreateAccountValidation validation;

  @override
  List<Object?> get props => super.props..add(validation);
}
