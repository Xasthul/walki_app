import 'package:flutter/material.dart';
import 'package:vall/app/common/theme/app_colors.dart';

class HomeTheme extends ThemeExtension<HomeTheme> {
  const HomeTheme._({
    required this.bottomNavigationBarBackground,
    required this.bottomNavigationBarSplash,
    required this.bottomNavigationBarSelectedIcon,
  });

  factory HomeTheme.light() => const HomeTheme._(
        bottomNavigationBarBackground: AppColors.white,
        bottomNavigationBarSplash: AppColors.transparent,
        bottomNavigationBarSelectedIcon: AppColors.primary700,
      );

  final Color bottomNavigationBarBackground;
  final Color bottomNavigationBarSplash;
  final Color bottomNavigationBarSelectedIcon;

  @override
  ThemeExtension<HomeTheme> copyWith({
    Color? bottomNavigationBarBackground,
    Color? bottomNavigationBarSplash,
    Color? bottomNavigationBarSelectedIcon,
  }) {
    return HomeTheme._(
      bottomNavigationBarBackground: bottomNavigationBarBackground ?? this.bottomNavigationBarBackground,
      bottomNavigationBarSplash: bottomNavigationBarSplash ?? this.bottomNavigationBarSplash,
      bottomNavigationBarSelectedIcon: bottomNavigationBarSelectedIcon ?? this.bottomNavigationBarSelectedIcon,
    );
  }

  @override
  ThemeExtension<HomeTheme> lerp(
    ThemeExtension<HomeTheme>? other,
    double t,
  ) {
    if (other is! HomeTheme) {
      return this;
    }
    return HomeTheme._(
      bottomNavigationBarBackground: Color.lerp(bottomNavigationBarBackground, other.bottomNavigationBarBackground, t)!,
      bottomNavigationBarSplash: Color.lerp(bottomNavigationBarSplash, other.bottomNavigationBarSplash, t)!,
      bottomNavigationBarSelectedIcon:
          Color.lerp(bottomNavigationBarSelectedIcon, other.bottomNavigationBarSelectedIcon, t)!,
    );
  }
}

extension HomeThemeExtension on BuildContext {
  HomeTheme get homeTheme => Theme.of(this).extension<HomeTheme>()!;
}
