part of 'places_cubit.dart';

sealed class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object?> get props => [];
}

class PlacesNotDiscovered extends PlacesState {}

class PlacesDiscovered extends PlacesState {
  const PlacesDiscovered(this.places);

  final List<PointOfInterest> places;

  @override
  List<Object?> get props => super.props..add(places);
}
