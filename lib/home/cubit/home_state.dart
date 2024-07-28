part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeGetLocationPermissionSuccess extends HomeState {}

class HomeGetLocationPermissionFailed extends HomeState {}
