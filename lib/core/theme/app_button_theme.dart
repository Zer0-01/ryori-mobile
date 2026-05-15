import 'package:flutter/material.dart';
import 'package:ryori/core/theme/app_color_scheme.dart';

class AppButtonTokenValues {
  const AppButtonTokenValues._();

  static const double minHeight = 52;
  static const double borderRadius = 14;
  static const double outlinedBorderWidth = 1;
  static const EdgeInsets padding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 14,
  );
  static const TextStyle textStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );
}

class AppFilledButtonTheme {
  const AppFilledButtonTheme._();

  static final FilledButtonThemeData light = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(0, AppButtonTokenValues.minHeight),
      padding: AppButtonTokenValues.padding,
      textStyle: AppButtonTokenValues.textStyle,
      backgroundColor: AppColorTokens.primary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: AppColorTokens.lightBorder,
      disabledForegroundColor: AppColorTokens.lightTextMuted,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppButtonTokenValues.borderRadius),
      ),
    ),
  );

  static final FilledButtonThemeData dark = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(0, AppButtonTokenValues.minHeight),
      padding: AppButtonTokenValues.padding,
      textStyle: AppButtonTokenValues.textStyle,
      backgroundColor: AppColorTokens.primaryLight,
      foregroundColor: AppColorTokens.darkBackground,
      disabledBackgroundColor: AppColorTokens.darkBorder,
      disabledForegroundColor: AppColorTokens.darkTextMuted,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppButtonTokenValues.borderRadius),
      ),
    ),
  );
}

class AppOutlinedButtonTheme {
  const AppOutlinedButtonTheme._();

  static final OutlinedButtonThemeData light = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(0, AppButtonTokenValues.minHeight),
      padding: AppButtonTokenValues.padding,
      textStyle: AppButtonTokenValues.textStyle,
      foregroundColor: AppColorTokens.lightText,
      disabledForegroundColor: AppColorTokens.lightTextMuted,
      side: const BorderSide(
        color: AppColorTokens.lightBorder,
        width: AppButtonTokenValues.outlinedBorderWidth,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppButtonTokenValues.borderRadius),
      ),
    ),
  );

  static final OutlinedButtonThemeData dark = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(0, AppButtonTokenValues.minHeight),
      padding: AppButtonTokenValues.padding,
      textStyle: AppButtonTokenValues.textStyle,
      foregroundColor: AppColorTokens.darkText,
      disabledForegroundColor: AppColorTokens.darkTextMuted,
      side: const BorderSide(
        color: AppColorTokens.darkBorder,
        width: AppButtonTokenValues.outlinedBorderWidth,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppButtonTokenValues.borderRadius),
      ),
    ),
  );
}

class AppTextButtonTheme {
  const AppTextButtonTheme._();

  static final TextButtonThemeData light = TextButtonThemeData(
    style: TextButton.styleFrom(
      minimumSize: const Size(0, AppButtonTokenValues.minHeight),
      padding: AppButtonTokenValues.padding,
      textStyle: AppButtonTokenValues.textStyle,
      foregroundColor: AppColorTokens.primary,
      disabledForegroundColor: AppColorTokens.lightTextMuted,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppButtonTokenValues.borderRadius),
      ),
    ),
  );

  static final TextButtonThemeData dark = TextButtonThemeData(
    style: TextButton.styleFrom(
      minimumSize: const Size(0, AppButtonTokenValues.minHeight),
      padding: AppButtonTokenValues.padding,
      textStyle: AppButtonTokenValues.textStyle,
      foregroundColor: AppColorTokens.primaryLight,
      disabledForegroundColor: AppColorTokens.darkTextMuted,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppButtonTokenValues.borderRadius),
      ),
    ),
  );
}

class AppElevatedButtonTheme {
  const AppElevatedButtonTheme._();

  static final ElevatedButtonThemeData light = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(0, AppButtonTokenValues.minHeight),
      padding: AppButtonTokenValues.padding,
      textStyle: AppButtonTokenValues.textStyle,
      backgroundColor: AppColorTokens.lightSurface,
      foregroundColor: AppColorTokens.lightText,
      disabledBackgroundColor: AppColorTokens.lightBorder,
      disabledForegroundColor: AppColorTokens.lightTextMuted,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppButtonTokenValues.borderRadius),
      ),
    ),
  );

  static final ElevatedButtonThemeData dark = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(0, AppButtonTokenValues.minHeight),
      padding: AppButtonTokenValues.padding,
      textStyle: AppButtonTokenValues.textStyle,
      backgroundColor: AppColorTokens.darkSurfaceContainer,
      foregroundColor: AppColorTokens.darkText,
      disabledBackgroundColor: AppColorTokens.darkBorder,
      disabledForegroundColor: AppColorTokens.darkTextMuted,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppButtonTokenValues.borderRadius),
      ),
    ),
  );
}
