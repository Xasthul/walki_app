import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';
import 'package:vall/home/misc/logger/logger.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(ProfileInitial());

  final AuthenticationRepository _authenticationRepository;

  Future<void> logOut() async {
    try {
      await _authenticationRepository.logOut();
    } catch (error, stackTrace) {
      logger.e('Log out failed', error: error, stackTrace: stackTrace);
    }
  }
}
