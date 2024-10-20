part of 'trip_settings_component.dart';

class _TripSettingsNotchDelegate extends SliverPersistentHeaderDelegate {
  _TripSettingsNotchDelegate();

  static const double _notchHeight = 3;
  static const double _notchVerticalPadding = 12;
  static const double _totalHeight = _notchHeight + _notchVerticalPadding * 2;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) =>
      DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            height: _notchHeight,
            width: 64,
            margin: const EdgeInsets.symmetric(vertical: _notchVerticalPadding),
          ),
        ),
      );

  @override
  double get maxExtent => _totalHeight;

  @override
  double get minExtent => _totalHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
