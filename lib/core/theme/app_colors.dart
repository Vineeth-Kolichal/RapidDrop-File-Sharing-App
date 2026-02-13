import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  //TODO: Add branding based theme colors
  final Color? primary;
  final Color? secondary;

  //Utility colors
  final Color? surfaceColor;
  final Color? onSurface;
  final Color? appBarColor;

  //constant colors
  final Color kBlack;
  final Color kWhite;

  const AppColors({
    required this.primary,
    required this.secondary,
    required this.surfaceColor,
    required this.onSurface,
    required this.appBarColor,
    this.kBlack = Colors.black,
    this.kWhite = Colors.white,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? secondary,
    Color? surfaceColor,
    Color? onSurface,
    Color? appBarColor,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      onSurface: onSurface ?? this.onSurface,
      appBarColor: appBarColor ?? this.appBarColor,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(
        primary,
        other.primary,
        t,
      ),
      secondary: Color.lerp(
        secondary,
        other.secondary,
        t,
      ),
      surfaceColor: Color.lerp(
        surfaceColor,
        other.surfaceColor,
        t,
      ),
      onSurface: Color.lerp(
        onSurface,
        other.onSurface,
        t,
      ),
      appBarColor: Color.lerp(
        appBarColor,
        other.appBarColor,
        t,
      ),
    );
  }
}

