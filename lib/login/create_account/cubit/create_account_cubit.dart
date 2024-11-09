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

  Future<void> createAccount() async {
    const email = 'email@email.com';
    const name = 'name';
    const password = 'password';

    try {
      await _authenticationRepository.register(
        email: email,
        name: name,
        password: password,
      );
    } catch (error, stackTrace) {
      logger.e('Failed to create account', error: error, stackTrace: stackTrace);
    }
  }
}
