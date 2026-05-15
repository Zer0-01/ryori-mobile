import 'package:flutter/material.dart';
import 'package:ryori/core/theme/app_color_scheme.dart';

class AppCardTokenValues {
  const AppCardTokenValues._();

  static const double borderRadius = 20;
  static const double elevation = 0;
  static const EdgeInsets margin = EdgeInsets.zero;
}

class AppCardTheme {
  const AppCardTheme._();

  static final CardThemeData light = CardThemeData(
    color: AppColorTokens.lightSurface,
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: AppCardTokenValues.elevation,
    margin: AppCardTokenValues.margin,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppCardTokenValues.borderRadius),
      side: const BorderSide(color: AppColorTokens.lightBorder),
    ),
  );

  static final CardThemeData dark = CardThemeData(
    color: AppColorTokens.darkSurfaceContainer,
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: AppCardTokenValues.elevation,
    margin: AppCardTokenValues.margin,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppCardTokenValues.borderRadius),
      side: const BorderSide(color: AppColorTokens.darkBorder),
    ),
  );
}
