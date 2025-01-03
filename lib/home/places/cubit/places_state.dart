part of 'places_cubit.dart';

sealed class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object?> get props => [];
}

class PlacesNotDiscovered extends PlacesState {}

class PlacesDiscovered extends PlacesState {
  const PlacesDiscovered({
    required this.discovered,
    required this.inTrip,
  });

  final FoundPlaces discovered;
  final List<Place> inTrip;

  PlacesDiscovered copyWith({
    FoundPlaces? discovered,
    List<Place>? inTrip,
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
