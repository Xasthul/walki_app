part of 'trip_cubit.dart';

sealed class TripState extends Equatable {
  const TripState();

  @override
  List<Object?> get props => [];
}

class TripInitialLocationLoading extends TripState {}

class TripInitialLocationLoaded extends TripState {}

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
