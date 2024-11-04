import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';
import 'package:vall/home/misc/logger/logger.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(AuthenticationLoading());

  final AuthenticationRepository _authenticationRepository;

  StreamSubscription<bool>? _isAuthenticatedSubscription;

  Future<void> load() async {
    try {
      _isAuthenticatedSubscription = _authenticationRepository.isAuthenticatedStream.listen(_onIsAuthenticatedChanged);
      _onIsAuthenticatedChanged(await _authenticationRepository.isAuthenticated);
    } catch (error, stackTrace) {
      logger.e('Authentication cubit load failed', error: error, stackTrace: stackTrace);
    }
  }

  void _onIsAuthenticatedChanged(bool isAuthenticated) {
    if (isAuthenticated) {
      return emit(AuthenticationSet());
    }
    return emit(AuthenticationNotSet());
  }

  @override
  Future<void> close() {
    _isAuthenticatedSubscription?.cancel();
    return super.close();
  }
}
