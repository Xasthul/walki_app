import 'package:vall/home/misc/entity/point_of_interest.dart';
import 'package:vall/home/profile/misc/service/visited_places_service.dart';

class VisitedPlacesRepository {
  VisitedPlacesRepository({
    required VisitedPlacesService visitedPlacesService,
  }) : _visitedPlacesService = visitedPlacesService;

  final VisitedPlacesService _visitedPlacesService;

  Future<List<PointOfInterest>> loadVisitedPlaces() async {
    final now = DateTime.now();
    final response = await _visitedPlacesService.getVisitedPlaces(
      fromDate: DateTime(now.year).toUtc().toIso8601String(),
    );
    return response
        .map(
          (item) => PointOfInterest(
            name: item.name,
            latitude: item.latitude,
            longitude: item.longitude,
          ),
        )
        .toList();
  }

  Future<void> visitPlace(PointOfInterest place) async => _visitedPlacesService.visitPlace(
        name: place.name,
        latitude: place.latitude,
        longitude: place.longitude,
      );
}
