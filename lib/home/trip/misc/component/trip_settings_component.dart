import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/home/trip/cubit/trip_cubit.dart';

part 'trip_settings_content.dart';

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
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        height: 3,
                        width: 64,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                    _TripSettingsContent(collapseSettings: _collapse),
                  ]),
                ),
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
