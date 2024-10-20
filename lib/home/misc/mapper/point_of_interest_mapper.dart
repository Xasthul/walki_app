import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/misc/network/entity/response/google_api_place.dart';

class PointOfInterestMapper {
  PointOfInterest mapFromGoogleApiPlace(GoogleApiPlace googleApiPlace) => PointOfInterest(
        name: googleApiPlace.displayName.text,
        latitude: googleApiPlace.location.latitude,
        longitude: googleApiPlace.location.longitude,
      );
}
