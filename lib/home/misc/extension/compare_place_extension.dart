import 'package:vall/home/misc/entity/place.dart';
import 'package:vall/home/profile/misc/entity/visited_place.dart';

extension ComparePlaceExtension on Place {
  bool isSameAs(VisitedPlace place) => name == place.name && latitude == place.latitude && longitude == place.longitude;
}
