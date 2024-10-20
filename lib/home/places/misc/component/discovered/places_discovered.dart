part of '../../../places_page.dart';

class _PlacesDiscovered extends StatefulWidget {
  const _PlacesDiscovered({
    required List<PointOfInterest> discoveredPlaces,
    required List<PointOfInterest> placesInTrip,
  })  : _discoveredPlaces = discoveredPlaces,
        _placesInTrip = placesInTrip;

  final List<PointOfInterest> _discoveredPlaces;
  final List<PointOfInterest> _placesInTrip;

  @override
  State<_PlacesDiscovered> createState() => _PlacesDiscoveredState();
}

class _PlacesDiscoveredState extends State<_PlacesDiscovered> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Discovered'),
              Tab(text: 'In trip'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _PlacesDiscoveredTab(
                  discoveredPlaces: widget._discoveredPlaces,
                  placesInTrip: widget._placesInTrip,
                ),
                _PlacesInTripTab(placesInTrip: widget._placesInTrip),
              ],
            ),
          ),
        ],
      );
}
