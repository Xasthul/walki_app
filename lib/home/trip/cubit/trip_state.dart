part of 'trip_cubit.dart';

sealed class TripState extends Equatable {
  const TripState();

  @override
  List<Object?> get props => [];
}

class InitialLocationLoading extends TripState {}

class InitialLocationLoaded extends TripState {}

class GetInitialLocationFailed extends TripState {
  const GetInitialLocationFailed(this.error);

  final dynamic error;

  @override
  List<Object?> get props => super.props..add(error);
}

class TripLoading extends TripState {}

class TripCreated extends TripState {
  const TripCreated({
    required this.polylineId,
    required this.polylinePoints,
  });

  final PolylineId polylineId;
  final List<LatLng> polylinePoints;

  @override
  List<Object?> get props => super.props
    ..addAll([
      polylineId,
      polylinePoints,
    ]);
}

class TripCreationFailed extends TripState {}
