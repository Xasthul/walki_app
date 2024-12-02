import 'package:flutter/material.dart';
import 'package:vall/app/common/theme/app_colors.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) => const CircularProgressIndicator(
        color: AppColors.primary700,
      );
}
