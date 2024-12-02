import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/utils/logger.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/profile/misc/entity/user.dart';
import 'package:vall/home/profile/misc/repository/user_repository.dart';
import 'package:vall/home/profile/misc/repository/visited_places_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
    required VisitedPlacesRepository visitedPlacesRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        _visitedPlacesRepository = visitedPlacesRepository,
        super(const ProfileIdle(visitedPlaces: []));

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final VisitedPlacesRepository _visitedPlacesRepository;

  Future<void> load() async {
    emit(const ProfileLoading(visitedPlaces: []));
    try {
      // TODO(naz): if one of these fails we get no info at all
      final user = await _userRepository.loadUserData();
      final visitedPlaces = await _visitedPlacesRepository.loadVisitedPlaces();
      emit(ProfileIdle(user: user, visitedPlaces: visitedPlaces));
    } catch (error, stackTrace) {
      logger.e('Load user data failed', error: error, stackTrace: stackTrace);
      emit(const ProfileIdle(visitedPlaces: []));
    }
  }

  Future<void> logOut() async {
    try {
      await _authenticationRepository.logOut();
    } catch (error, stackTrace) {
      logger.e('Log out failed', error: error, stackTrace: stackTrace);
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _userRepository.deleteAccount();
      await _authenticationRepository.logOut();
    } catch (error, stackTrace) {
      logger.e('Delete account failed', error: error, stackTrace: stackTrace);
    }
  }
}
