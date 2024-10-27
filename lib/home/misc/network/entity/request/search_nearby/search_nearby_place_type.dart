import 'package:json_annotation/json_annotation.dart';

enum SearchNearbyPlaceType {
  @JsonValue('tourist_attraction')
  touristAttraction,
  @JsonValue('restaurant')
  restaurant,
  @JsonValue('cafe')
  cafe,
}
