import 'package:flutter/material.dart';
import 'package:ryori/core/theme/app_color_scheme.dart';

class AppBarTokenValues {
  const AppBarTokenValues._();

  static const double elevation = 0;
  static const double scrolledUnderElevation = 0;
  static const double centerTitleSpacing = 20;
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  );
}

class AppAppBarTheme {
  const AppAppBarTheme._();

  static final AppBarTheme light = AppBarTheme(
    backgroundColor: AppColorTokens.lightBackground,
    foregroundColor: AppColorTokens.lightText,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: AppBarTokenValues.elevation,
    scrolledUnderElevation: AppBarTokenValues.scrolledUnderElevation,
    centerTitle: false,
    titleSpacing: AppBarTokenValues.centerTitleSpacing,
    titleTextStyle: AppBarTokenValues.titleTextStyle.copyWith(
      color: AppColorTokens.lightText,
    ),
  );

  static final AppBarTheme dark = AppBarTheme(
    backgroundColor: AppColorTokens.darkBackground,
    foregroundColor: AppColorTokens.darkText,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: AppBarTokenValues.elevation,
    scrolledUnderElevation: AppBarTokenValues.scrolledUnderElevation,
    centerTitle: false,
    titleSpacing: AppBarTokenValues.centerTitleSpacing,
    titleTextStyle: AppBarTokenValues.titleTextStyle.copyWith(
      color: AppColorTokens.darkText,
    ),
  );
}
