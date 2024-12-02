import 'package:flutter/material.dart';
import 'package:vall/app/common/widget/app_loading_indicator.dart';

class AppLoadingPage extends StatelessWidget {
  const AppLoadingPage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: AppLoadingIndicator()),
      );
}
