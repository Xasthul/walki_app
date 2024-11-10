import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/login/create_account/misc/validator/create_account_validation.dart';
import 'package:vall/login/create_account/misc/validator/create_account_validator.dart';

part 'create_account_validation_state.dart';

class CreateAccountValidationCubit extends Cubit<CreateAccountValidationState> {
  CreateAccountValidationCubit({
    required CreateAccountValidator createAccountValidator,
  })  : _createAccountValidator = createAccountValidator,
        super(const CreateAccountValidationInitial());

  final CreateAccountValidator _createAccountValidator;

  void onNameChanged(String name) => emit(
        CreateAccountValidationUpdated(
          name: name,
          email: state.email,
          password: state.password,
          confirmPassword: state.confirmPassword,
        ),
      );

  void onEmailChanged(String email) => emit(
        CreateAccountValidationUpdated(
          name: state.name,
          email: email,
          password: state.password,
          confirmPassword: state.confirmPassword,
        ),
      );

  void onPasswordChanged(String password) => emit(
        CreateAccountValidationUpdated(
          name: state.name,
          email: state.email,
          password: password,
          confirmPassword: state.confirmPassword,
        ),
      );

  void onConfirmPasswordChanged(String confirmPassword) => emit(
        CreateAccountValidationUpdated(
          name: state.name,
          email: state.email,
          password: state.password,
          confirmPassword: confirmPassword,
        ),
      );

  void validate() {
    final validation = _createAccountValidator.validate(
      name: state.name,
      email: state.email,
      password: state.password,
      confirmPassword: state.confirmPassword,
    );
    if (!validation.isValid) {
      return emit(CreateAccountValidationFailed(state, validation: validation));
    }
    emit(CreateAccountValidationSucceeded(state));
  }
}
