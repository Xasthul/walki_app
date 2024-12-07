part of 'current_location_cubit.dart';

sealed class CurrentLocationState extends Equatable {
  const CurrentLocationState();

  @override
  List<Object?> get props => [];
}

class CurrentLocationLoading extends CurrentLocationState {}

class CurrentLocationUpdated extends CurrentLocationState {
  const CurrentLocationUpdated({required this.location});

  final LatLng location;

  @override
  List<Object?> get props => super.props..add(location);
}
