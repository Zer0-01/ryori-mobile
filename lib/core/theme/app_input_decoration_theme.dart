import 'package:flutter/material.dart';
import 'package:ryori/core/theme/app_color_scheme.dart';

class AppInputDecorationTokenValues {
  const AppInputDecorationTokenValues._();

  static const double borderRadius = 14;
  static const double borderWidth = 1;
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 16,
  );
  static const TextStyle labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle hintStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle helperStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle errorStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}

class AppInputDecorationTheme {
  const AppInputDecorationTheme._();

  static OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppInputDecorationTokenValues.borderRadius,
      ),
      borderSide: BorderSide(
        color: color,
        width: AppInputDecorationTokenValues.borderWidth,
      ),
    );
  }

  static final InputDecorationTheme light = InputDecorationTheme(
    isDense: true,
    filled: true,
    fillColor: AppColorTokens.lightSurfaceContainer,
    contentPadding: AppInputDecorationTokenValues.contentPadding,
    labelStyle: AppInputDecorationTokenValues.labelStyle.copyWith(
      color: AppColorTokens.lightTextMuted,
    ),
    hintStyle: AppInputDecorationTokenValues.hintStyle.copyWith(
      color: AppColorTokens.lightTextMuted,
    ),
    helperStyle: AppInputDecorationTokenValues.helperStyle.copyWith(
      color: AppColorTokens.lightTextMuted,
    ),
    errorStyle: AppInputDecorationTokenValues.errorStyle.copyWith(
      color: AppColorTokens.error,
    ),
    prefixIconColor: AppColorTokens.lightTextMuted,
    suffixIconColor: AppColorTokens.lightTextMuted,
    border: _border(AppColorTokens.lightBorder),
    enabledBorder: _border(AppColorTokens.lightBorder),
    focusedBorder: _border(AppColorTokens.primary),
    errorBorder: _border(AppColorTokens.error),
    focusedErrorBorder: _border(AppColorTokens.error),
  );

  static final InputDecorationTheme dark = InputDecorationTheme(
    isDense: true,
    filled: true,
    fillColor: AppColorTokens.darkSurfaceContainer,
    contentPadding: AppInputDecorationTokenValues.contentPadding,
    labelStyle: AppInputDecorationTokenValues.labelStyle.copyWith(
      color: AppColorTokens.darkTextMuted,
    ),
    hintStyle: AppInputDecorationTokenValues.hintStyle.copyWith(
      color: AppColorTokens.darkTextMuted,
    ),
    helperStyle: AppInputDecorationTokenValues.helperStyle.copyWith(
      color: AppColorTokens.darkTextMuted,
    ),
    errorStyle: AppInputDecorationTokenValues.errorStyle.copyWith(
      color: AppColorTokens.error,
    ),
    prefixIconColor: AppColorTokens.darkTextMuted,
    suffixIconColor: AppColorTokens.darkTextMuted,
    border: _border(AppColorTokens.darkBorder),
    enabledBorder: _border(AppColorTokens.darkBorder),
    focusedBorder: _border(AppColorTokens.primaryLight),
    errorBorder: _border(AppColorTokens.error),
    focusedErrorBorder: _border(AppColorTokens.error),
  );
}
