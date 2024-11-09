import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/logger/logger.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginInitial());

  final AuthenticationRepository _authenticationRepository;

  Future<void> login() async {
    emit(LoginLoading(state));
    try {
      await _authenticationRepository.login(
        email: state.email,
        password: state.password,
      );
    } catch (error, stackTrace) {
      emit(LoginFailed(
        state,
        errorMessage: 'Login failed',
      ));
      logger.e('Login failed', error: error, stackTrace: stackTrace);
    }
  }

  void onEmailChanged(String email) => emit(state.copyWith(email: email));

  void onPasswordChanged(String password) => emit(state.copyWith(password: password));
}
