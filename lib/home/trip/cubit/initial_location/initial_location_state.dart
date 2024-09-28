part of 'initial_location_cubit.dart';

sealed class InitialLocationState extends Equatable {
  const InitialLocationState();

  @override
  List<Object?> get props => [];
}

class InitialLocationLoading extends InitialLocationState {}

class InitialLocationLoaded extends InitialLocationState {
  const InitialLocationLoaded({required this.location});

  final LatLng location;

  @override
  List<Object?> get props => super.props..add(location);
}
