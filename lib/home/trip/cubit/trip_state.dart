part of 'trip_cubit.dart';

sealed class TripState extends Equatable {
  const TripState();

  @override
  List<Object?> get props => [];
}

class TripCurrentLocationLoading extends TripState {}

class TripInitial extends TripState {}

class TripLoading extends TripState {}

class TripCreated extends TripState {
  const TripCreated({
    required this.polylinePoints,
    required this.tripSteps,
  });

  final List<LatLng> polylinePoints;
  final List<LatLng> tripSteps;

  @override
  List<Object?> get props => super.props
    ..addAll([
      polylinePoints,
      tripSteps,
    ]);
}

class TripCreationFailed extends TripState {}
