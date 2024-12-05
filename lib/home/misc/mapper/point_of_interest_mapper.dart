import 'package:vall/app/common/constants/app_constants.dart';
import 'package:vall/home/misc/entity/place.dart';
import 'package:vall/home/misc/network/entity/response/google_api_place.dart';

class PointOfInterestMapper {
  GooglePlace mapFromGoogleApiPlace(GoogleApiPlace googleApiPlace) {
    final firstPhotoName = googleApiPlace.photos.first.name;
    final photoUrl =
        'https://places.googleapis.com/v1/$firstPhotoName/media?maxHeightPx=400&maxWidthPx=640&key=${AppConstants.googleApiKey}';
    return GooglePlace(
      name: googleApiPlace.displayName.text,
      latitude: googleApiPlace.location.latitude,
      longitude: googleApiPlace.location.longitude,
      photoUrl: photoUrl,
    );
  }
}
