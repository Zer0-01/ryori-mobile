import 'package:flutter/material.dart';
import 'package:ryori/core/theme/app_color_scheme.dart';

class AppFloatingActionButtonTokenValues {
  const AppFloatingActionButtonTokenValues._();

  static const double elevation = 0;
  static const double focusElevation = 0;
  static const double hoverElevation = 0;
  static const double highlightElevation = 0;
  static const double disabledElevation = 0;
  static const double extendedTextStyleSize = 14;
  static const FontWeight extendedTextStyleWeight = FontWeight.w600;
}

class AppFloatingActionButtonTheme {
  const AppFloatingActionButtonTheme._();

  static const FloatingActionButtonThemeData light =
      FloatingActionButtonThemeData(
        backgroundColor: AppColorTokens.primary,
        foregroundColor: Colors.white,
        focusColor: AppColorTokens.primaryDark,
        hoverColor: AppColorTokens.primaryDark,
        splashColor: Color(0x1FFFFFFF),
        elevation: AppFloatingActionButtonTokenValues.elevation,
        focusElevation: AppFloatingActionButtonTokenValues.focusElevation,
        hoverElevation: AppFloatingActionButtonTokenValues.hoverElevation,
        highlightElevation:
            AppFloatingActionButtonTokenValues.highlightElevation,
        disabledElevation:
            AppFloatingActionButtonTokenValues.disabledElevation,
        extendedTextStyle: TextStyle(
          fontSize: AppFloatingActionButtonTokenValues.extendedTextStyleSize,
          fontWeight:
              AppFloatingActionButtonTokenValues.extendedTextStyleWeight,
        ),
      );

  static const FloatingActionButtonThemeData dark =
      FloatingActionButtonThemeData(
        backgroundColor: AppColorTokens.primaryLight,
        foregroundColor: AppColorTokens.darkBackground,
        focusColor: AppColorTokens.primary,
        hoverColor: AppColorTokens.primary,
        splashColor: Color(0x1F000000),
        elevation: AppFloatingActionButtonTokenValues.elevation,
        focusElevation: AppFloatingActionButtonTokenValues.focusElevation,
        hoverElevation: AppFloatingActionButtonTokenValues.hoverElevation,
        highlightElevation:
            AppFloatingActionButtonTokenValues.highlightElevation,
        disabledElevation:
            AppFloatingActionButtonTokenValues.disabledElevation,
        extendedTextStyle: TextStyle(
          fontSize: AppFloatingActionButtonTokenValues.extendedTextStyleSize,
          fontWeight:
              AppFloatingActionButtonTokenValues.extendedTextStyleWeight,
        ),
      );
}
