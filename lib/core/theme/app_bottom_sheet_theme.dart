import 'package:flutter/material.dart';
import 'package:ryori/core/theme/app_color_scheme.dart';

class AppBottomSheetTokenValues {
  const AppBottomSheetTokenValues._();

  static const double borderRadius = 24;
  static const double elevation = 0;
}

class AppBottomSheetTheme {
  const AppBottomSheetTheme._();

  static final BottomSheetThemeData light = const BottomSheetThemeData(
    backgroundColor: AppColorTokens.lightSurface,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: AppBottomSheetTokenValues.elevation,
    modalBackgroundColor: AppColorTokens.lightSurface,
    modalBarrierColor: Color(0x52000000),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppBottomSheetTokenValues.borderRadius),
      ),
    ),
    clipBehavior: Clip.antiAlias,
  );

  static final BottomSheetThemeData dark = const BottomSheetThemeData(
    backgroundColor: AppColorTokens.darkSurfaceContainer,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: AppBottomSheetTokenValues.elevation,
    modalBackgroundColor: AppColorTokens.darkSurfaceContainer,
    modalBarrierColor: Color(0x99000000),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppBottomSheetTokenValues.borderRadius),
      ),
    ),
    clipBehavior: Clip.antiAlias,
  );
}
