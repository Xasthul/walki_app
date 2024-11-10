import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/logger/logger.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(CreateAccountInitial());

  final AuthenticationRepository _authenticationRepository;

  Future<void> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(CreateAccountLoading());
    try {
      await _authenticationRepository.register(
        email: email,
        name: name,
        password: password,
      );
      emit(
        CreateAccountSucceeded(
          email: email,
          password: password,
        ),
      );
    } catch (error, stackTrace) {
      emit(const CreateAccountFailed(errorMessage: 'Failed to create account'));
      logger.e('Failed to create account', error: error, stackTrace: stackTrace);
    }
  }
}
