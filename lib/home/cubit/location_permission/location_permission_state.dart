part of 'location_permission_cubit.dart';

sealed class LocationPermissionState extends Equatable {
  const LocationPermissionState();

  @override
  List<Object?> get props => [];
}

class LocationPermissionInitial extends LocationPermissionState {}

class LocationPermissionProvided extends LocationPermissionState {}

class LocationPermissionNotProvided extends LocationPermissionState {}
