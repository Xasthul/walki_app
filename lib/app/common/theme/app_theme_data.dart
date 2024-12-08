import 'package:flutter/material.dart';
import 'package:vall/app/common/theme/app_colors.dart';
import 'package:vall/app/common/theme/home_theme.dart';

class AppThemeData {
  const AppThemeData({required this.themeData});

  factory AppThemeData.defaultTheme() => AppThemeData(
        themeData: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.white,
          ),
          extensions: [
            HomeTheme.light(),
          ],
        ),
      );

  final ThemeData themeData;
}
