part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState({this.user});

  final User? user;

  @override
  List<Object?> get props => [user];
}

class ProfileIdle extends ProfileState {
  const ProfileIdle({super.user});
}

class ProfileLoading extends ProfileState {
  const ProfileLoading({super.user});
}
