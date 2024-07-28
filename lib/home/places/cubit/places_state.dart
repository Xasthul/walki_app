part of 'places_cubit.dart';

sealed class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object?> get props => [];
}

class PlacesNoTripCreated extends PlacesState {}

class PlacesTripCreated extends PlacesState {}
