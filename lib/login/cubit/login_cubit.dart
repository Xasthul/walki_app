import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/utils/logger.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginInitial());

  final AuthenticationRepository _authenticationRepository;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const LoginLoading());
    try {
      await _authenticationRepository.login(
        email: email,
        password: password,
      );
    } catch (error, stackTrace) {
      emit(const LoginFailed(errorMessage: 'Login failed'));
      logger.e('Login failed', error: error, stackTrace: stackTrace);
    }
  }
}
