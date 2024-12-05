import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/misc/network/entity/response/google_api_place.dart';

class PointOfInterestMapper {
  PointOfInterest mapFromGoogleApiPlace(GoogleApiPlace googleApiPlace) {
    final firstPhotoName = googleApiPlace.photos.first.name;
    final photoUrl =
        'https://places.googleapis.com/v1/$firstPhotoName/media?maxHeightPx=400&maxWidthPx=640&key=${AppConstants.googleApiKey}';
    return PointOfInterest(
      name: googleApiPlace.displayName.text,
      latitude: googleApiPlace.location.latitude,
      longitude: googleApiPlace.location.longitude,
      photoUrl: photoUrl,
    );
  }
}
