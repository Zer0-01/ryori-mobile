import 'package:flutter/material.dart';
import 'package:ryori/core/theme/app_color_scheme.dart';

class AppDialogTokenValues {
  const AppDialogTokenValues._();

  static const double borderRadius = 24;
  static const double elevation = 0;
  static const EdgeInsets insetPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 24,
  );
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  );
  static const TextStyle contentTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
}

class AppDialogTheme {
  const AppDialogTheme._();

  static final DialogThemeData light = DialogThemeData(
    backgroundColor: AppColorTokens.lightSurface,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: AppDialogTokenValues.elevation,
    insetPadding: AppDialogTokenValues.insetPadding,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDialogTokenValues.borderRadius),
    ),
    titleTextStyle: AppDialogTokenValues.titleTextStyle.copyWith(
      color: AppColorTokens.lightText,
    ),
    contentTextStyle: AppDialogTokenValues.contentTextStyle.copyWith(
      color: AppColorTokens.lightTextMuted,
    ),
  );

  static final DialogThemeData dark = DialogThemeData(
    backgroundColor: AppColorTokens.darkSurfaceContainer,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: AppDialogTokenValues.elevation,
    insetPadding: AppDialogTokenValues.insetPadding,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDialogTokenValues.borderRadius),
    ),
    titleTextStyle: AppDialogTokenValues.titleTextStyle.copyWith(
      color: AppColorTokens.darkText,
    ),
    contentTextStyle: AppDialogTokenValues.contentTextStyle.copyWith(
      color: AppColorTokens.darkTextMuted,
    ),
  );
}
