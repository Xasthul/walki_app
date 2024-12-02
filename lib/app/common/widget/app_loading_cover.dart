import 'package:flutter/material.dart';
import 'package:vall/app/common/widget/app_loading_indicator.dart';

class AppLoadingCover extends StatelessWidget {
  const AppLoadingCover({super.key});

  @override
  Widget build(BuildContext context) => AbsorbPointer(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white.withOpacity(0.6),
          child: const Center(child: AppLoadingIndicator()),
        ),
      );
}
