part of 'places_cubit.dart';

sealed class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object?> get props => [];
}

class PlacesNotDiscovered extends PlacesState {}

class PlacesDiscovered extends PlacesState {
  const PlacesDiscovered({
    this.discovered = const [],
    this.inTrip = const [],
  });

  final List<PointOfInterest> discovered;
  final List<PointOfInterest> inTrip;

  PlacesDiscovered copyWith({
    List<PointOfInterest>? discovered,
    List<PointOfInterest>? inTrip,
  }) =>
      PlacesDiscovered(
        discovered: discovered ?? this.discovered,
        inTrip: inTrip ?? this.inTrip,
      );

  @override
  List<Object?> get props => super.props
    ..addAll([
      discovered,
      inTrip,
    ]);
}
