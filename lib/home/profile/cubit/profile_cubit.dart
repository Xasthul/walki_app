import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';
import 'package:vall/home/misc/logger/logger.dart';
import 'package:vall/home/profile/utils/entity/user.dart';
import 'package:vall/home/profile/utils/repository/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const ProfileIdle());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  Future<void> load() async {
    emit(const ProfileLoading());
    try {
      final user = await _userRepository.loadUserData();
      emit(ProfileIdle(user: user));
    } catch (error, stackTrace) {
      logger.e('Load user data failed', error: error, stackTrace: stackTrace);
      emit(const ProfileIdle());
    }
  }

  Future<void> logOut() async {
    try {
      await _authenticationRepository.logOut();
    } catch (error, stackTrace) {
      logger.e('Log out failed', error: error, stackTrace: stackTrace);
    }
  }
}
