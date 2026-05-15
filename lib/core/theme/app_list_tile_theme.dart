import 'package:flutter/material.dart';
import 'package:ryori/core/theme/app_color_scheme.dart';

class AppListTileTokenValues {
  const AppListTileTokenValues._();

  static const double borderRadius = 16;
  static const double minTileHeight = 56;
  static const double horizontalTitleGap = 12;
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 4,
  );
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );
  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
}

class AppListTileTheme {
  const AppListTileTheme._();

  static final ListTileThemeData light = ListTileThemeData(
    contentPadding: AppListTileTokenValues.contentPadding,
    minTileHeight: AppListTileTokenValues.minTileHeight,
    horizontalTitleGap: AppListTileTokenValues.horizontalTitleGap,
    iconColor: AppColorTokens.lightTextMuted,
    textColor: AppColorTokens.lightText,
    tileColor: Colors.transparent,
    selectedTileColor: AppColorTokens.lightSurfaceContainer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppListTileTokenValues.borderRadius),
    ),
    titleTextStyle: AppListTileTokenValues.titleTextStyle.copyWith(
      color: AppColorTokens.lightText,
    ),
    subtitleTextStyle: AppListTileTokenValues.subtitleTextStyle.copyWith(
      color: AppColorTokens.lightTextMuted,
    ),
  );

  static final ListTileThemeData dark = ListTileThemeData(
    contentPadding: AppListTileTokenValues.contentPadding,
    minTileHeight: AppListTileTokenValues.minTileHeight,
    horizontalTitleGap: AppListTileTokenValues.horizontalTitleGap,
    iconColor: AppColorTokens.darkTextMuted,
    textColor: AppColorTokens.darkText,
    tileColor: Colors.transparent,
    selectedTileColor: AppColorTokens.darkSurfaceContainer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppListTileTokenValues.borderRadius),
    ),
    titleTextStyle: AppListTileTokenValues.titleTextStyle.copyWith(
      color: AppColorTokens.darkText,
    ),
    subtitleTextStyle: AppListTileTokenValues.subtitleTextStyle.copyWith(
      color: AppColorTokens.darkTextMuted,
    ),
  );
}
