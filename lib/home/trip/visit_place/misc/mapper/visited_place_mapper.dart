import 'package:vall/home/misc/entity/place.dart';
import 'package:vall/home/profile/misc/entity/visited_place.dart';
import 'package:vall/home/profile/misc/network/response/visited_place_response.dart';

class VisitedPlaceMapper {
  VisitedPlace mapVisitedPlaceFromResponse(VisitedPlaceResponse response) => VisitedPlace(
        name: response.name,
        latitude: response.latitude,
        longitude: response.longitude,
      );

  VisitedPlace mapVisitedPlaceFromPlace(Place place) => VisitedPlace(
        name: place.name,
        latitude: place.latitude,
        longitude: place.longitude,
      );
}
