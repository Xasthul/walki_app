part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState({this.user, required this.visitedPlaces});

  final User? user;
  final List<VisitedPlace> visitedPlaces;

  @override
  List<Object?> get props => [user, visitedPlaces];
}

class ProfileIdle extends ProfileState {
  const ProfileIdle({super.user, required super.visitedPlaces});
}

class ProfileLoading extends ProfileState {
  const ProfileLoading({super.user, required super.visitedPlaces});
}
