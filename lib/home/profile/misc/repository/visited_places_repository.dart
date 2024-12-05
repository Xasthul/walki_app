import 'package:vall/home/profile/misc/entity/visited_place.dart';
import 'package:vall/home/profile/misc/service/visited_places_service.dart';
import 'package:vall/home/trip/visit_place/misc/mapper/visited_place_mapper.dart';

class VisitedPlacesRepository {
  VisitedPlacesRepository({
    required VisitedPlacesService visitedPlacesService,
    required VisitedPlaceMapper visitedPlaceMapper,
  })  : _visitedPlacesService = visitedPlacesService,
        _visitedPlaceMapper = visitedPlaceMapper;

  final VisitedPlacesService _visitedPlacesService;
  final VisitedPlaceMapper _visitedPlaceMapper;

  Future<List<VisitedPlace>> loadVisitedPlaces() async {
    final now = DateTime.now();
    final response = await _visitedPlacesService.getVisitedPlaces(
      fromDate: DateTime(now.year).toUtc().toIso8601String(),
    );
    return response.map(_visitedPlaceMapper.mapVisitedPlaceFromResponse).toList();
  }

  Future<void> visitPlace(VisitedPlace place) async => _visitedPlacesService.visitPlace(
        name: place.name,
        latitude: place.latitude,
        longitude: place.longitude,
      );
}
