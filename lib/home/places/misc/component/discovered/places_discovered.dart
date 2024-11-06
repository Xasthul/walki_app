part of '../../../places_page.dart';

class _PlacesDiscovered extends StatefulWidget {
  const _PlacesDiscovered({
    required List<PointOfInterest> discoveredPlaces,
    required List<PointOfInterest> discoveredRestaurants,
    required List<PointOfInterest> discoveredCafes,
    required TripPlaces placesInTrip,
  })  : _discoveredPlaces = discoveredPlaces,
        _discoveredRestaurants = discoveredRestaurants,
        _discoveredCafes = discoveredCafes,
        _placesInTrip = placesInTrip;

  final List<PointOfInterest> _discoveredPlaces;
  final List<PointOfInterest> _discoveredRestaurants;
  final List<PointOfInterest> _discoveredCafes;
  final TripPlaces _placesInTrip;

  @override
  State<_PlacesDiscovered> createState() => _PlacesDiscoveredState();
}

class _PlacesDiscoveredState extends State<_PlacesDiscovered> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool get _shouldShowOthersTab => widget._discoveredRestaurants.isNotEmpty || widget._discoveredCafes.isNotEmpty;

  int get _numberOfTabs => _shouldShowOthersTab ? 3 : 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _numberOfTabs, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              const Tab(text: 'Discovered'),
              if (_shouldShowOthersTab) const Tab(text: 'Others'),
              const Tab(text: 'In trip'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _PlacesDiscoveredTab(
                  discoveredPlaces: widget._discoveredPlaces,
                  placesInTrip: widget._placesInTrip.discoveredPlaces,
                ),
                if (_shouldShowOthersTab)
                  _PlacesDiscoveredOthersTab(
                    discoveredRestaurants: widget._discoveredRestaurants,
                    discoveredCafes: widget._discoveredCafes,
                    placesInTrip: widget._placesInTrip.discoveredPlaces,
                  ),
                _PlacesInTripTab(placesInTrip: widget._placesInTrip),
              ],
            ),
          ),
        ],
      );
}
