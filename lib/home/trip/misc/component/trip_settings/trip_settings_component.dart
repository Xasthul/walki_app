import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/component/no_over_scroll_behaviour.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';
import 'package:vall/home/trip/misc/entity/trip_travel_mode.dart';

part 'travel_mode/trip_settings_travel_mode.dart';
part 'travel_mode/trip_settings_travel_mode_chip.dart';
part 'trip_settings_content.dart';
part 'trip_settings_notch_delegate.dart';
part 'trip_settings_search_radius.dart';

class TripSettingsComponent extends StatefulWidget {
  const TripSettingsComponent({super.key});

  @override
  State<TripSettingsComponent> createState() => _TripSettingsComponentState();
}

class _TripSettingsComponentState extends State<TripSettingsComponent> {
  final _sheet = GlobalKey();
  late DraggableScrollableController _controller;

  static const double _expandedSize = 0.5;

  @override
  void initState() {
    super.initState();
    _controller = DraggableScrollableController()..addListener(_onSizeChanged);
  }

  void _onSizeChanged() {
    if (_controller.size <= 0.05) {
      _collapse();
    }
  }

  void _collapse() => _controller.animateTo(
        (_sheet.currentWidget! as DraggableScrollableSheet).snapSizes!.first,
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeInOut,
      );

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final double collapsedSize = 72 / constraints.maxHeight;
          return DraggableScrollableSheet(
            key: _sheet,
            initialChildSize: collapsedSize,
            maxChildSize: _expandedSize,
            minChildSize: 0,
            snap: true,
            snapSizes: [collapsedSize, _expandedSize],
            controller: _controller,
            builder: (context, scrollController) => DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: CustomScrollView(
                controller: scrollController,
                scrollBehavior: NoOverScrollBehavior(),
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _TripSettingsNotchDelegate(),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _TripSettingsContent(collapseSettings: _collapse),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
