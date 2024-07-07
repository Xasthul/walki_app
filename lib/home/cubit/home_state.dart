part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class InitialLocationLoading extends HomeState {}

class InitialLocationLoaded extends HomeState {
  const InitialLocationLoaded(this.location);

  final LatLng location;

  @override
  List<Object?> get props => [...super.props, location];
}

class GetInitialLocationFailed extends HomeState {
  const GetInitialLocationFailed(this.error);

  final dynamic error;

  @override
  List<Object?> get props => [...super.props, error];
}

class GetLocationPermissionFailed extends HomeState {}
