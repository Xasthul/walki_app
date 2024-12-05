part of '../../../places_page.dart';

class _PlacesDiscovered extends StatefulWidget {
  const _PlacesDiscovered({
    required List<GooglePlace> discoveredPlaces,
    required List<GooglePlace> discoveredRestaurants,
    required List<GooglePlace> discoveredCafes,
    required List<Place> placesInTrip,
  })  : _discoveredPlaces = discoveredPlaces,
        _discoveredRestaurants = discoveredRestaurants,
        _discoveredCafes = discoveredCafes,
        _placesInTrip = placesInTrip;

  final List<GooglePlace> _discoveredPlaces;
  final List<GooglePlace> _discoveredRestaurants;
  final List<GooglePlace> _discoveredCafes;
  final List<Place> _placesInTrip;

  @override
  State<_PlacesDiscovered> createState() => _PlacesDiscoveredState();
}

class _PlacesDiscoveredState extends State<_PlacesDiscovered> with TickerProviderStateMixin {
  late TabController _tabController;

  bool get _shouldShowOthersTab => widget._discoveredRestaurants.isNotEmpty || widget._discoveredCafes.isNotEmpty;

  int get _numberOfTabs => _shouldShowOthersTab ? 3 : 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _numberOfTabs, vsync: this);
  }

  @override
  void didUpdateWidget(covariant _PlacesDiscovered oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_numberOfTabs != _tabController.length) {
      _tabController.dispose();
      _tabController = TabController(
        length: _numberOfTabs,
        initialIndex: _getInitialIndexAfterTabNumberChange(_tabController.index),
        vsync: this,
      );
    }
  }

  int _getInitialIndexAfterTabNumberChange(int oldIndex) {
    if (oldIndex == 0) {
      return 0;
    }
    if (_tabController.length < _numberOfTabs) {
      return 2;
    }
    if (oldIndex == 1) {
      return 0;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          TabBar(
            dividerColor: Colors.grey[400],
            indicatorColor: AppColors.primary700,
            labelColor: AppColors.primary700,
            overlayColor: const WidgetStatePropertyAll(AppColors.primary100),
            controller: _tabController,
            tabs: [
              const Tab(text: 'Discovered'),
              if (_shouldShowOthersTab) const Tab(text: 'Others'),
              const Tab(text: 'In trip'),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _PlacesDiscoveredTab(
                    discoveredPlaces: widget._discoveredPlaces,
                    placesInTrip: widget._placesInTrip,
                  ),
                  if (_shouldShowOthersTab)
                    _PlacesDiscoveredOthersTab(
                      discoveredRestaurants: widget._discoveredRestaurants,
                      discoveredCafes: widget._discoveredCafes,
                      placesInTrip: widget._placesInTrip,
                    ),
                  _PlacesInTripTab(placesInTrip: widget._placesInTrip),
                ],
              ),
            ),
          ),
        ],
      );
}
