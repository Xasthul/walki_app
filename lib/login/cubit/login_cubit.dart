import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/logger/logger.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(LoginInitial());

  final AuthenticationRepository _authenticationRepository;

  Future<void> login() async {
    const email = 'email@email.com';
    const password = 'password';

    try {
      await _authenticationRepository.login(
        email: email,
        password: password,
      );
    } catch (error, stackTrace) {
      logger.e('Login failed', error: error, stackTrace: stackTrace);
    }
  }
}
