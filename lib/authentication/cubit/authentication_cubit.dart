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

  Future<void> load() async {
    try {
      final isAccessTokenStored = await _authenticationRepository.isAccessTokenStored;
      if (isAccessTokenStored) {
        return emit(AuthenticationSet());
      }
    } catch (error, stackTrace) {
      logger.e('Failed to load access token from storage', error: error, stackTrace: stackTrace);
    }
    return emit(AuthenticationNotSet());
  }
}
