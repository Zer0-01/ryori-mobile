import 'package:flutter/material.dart';

class AppColorTokens {
  const AppColorTokens._();

  static const Color primary = Color(0xFFE91E63);
  static const Color primaryLight = Color(0xFFFF5C8D);
  static const Color primaryDark = Color(0xFFC2185B);

  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF000000);

  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkSurface = Color(0xFF121212);

  static const Color lightSurfaceContainer = Color(0xFFF6F6F6);
  static const Color darkSurfaceContainer = Color(0xFF1C1C1C);

  static const Color lightText = Color(0xFF111111);
  static const Color darkText = Color(0xFFF5F5F5);

  static const Color lightTextMuted = Color(0xFF5F5F5F);
  static const Color darkTextMuted = Color(0xFFB8B8B8);

  static const Color lightBorder = Color(0xFFE7E7E7);
  static const Color darkBorder = Color(0xFF2A2A2A);

  static const Color error = Color(0xFFB3261E);
}

class AppColorSchemeTokens {
  const AppColorSchemeTokens._();

  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: AppColorTokens.primary,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFFFD9E2),
    onPrimaryContainer: Color(0xFF3C001D),
    secondary: AppColorTokens.lightTextMuted,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFF3F3F3),
    onSecondaryContainer: AppColorTokens.lightText,
    tertiary: AppColorTokens.primaryDark,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFFFE0EA),
    onTertiaryContainer: Color(0xFF4A1027),
    error: AppColorTokens.error,
    onError: Colors.white,
    errorContainer: Color(0xFFF9DEDC),
    onErrorContainer: Color(0xFF410E0B),
    surface: AppColorTokens.lightSurface,
    onSurface: AppColorTokens.lightText,
    onSurfaceVariant: AppColorTokens.lightTextMuted,
    outline: AppColorTokens.lightBorder,
    outlineVariant: Color(0xFFF0F0F0),
    shadow: Color(0x14000000),
    scrim: Color(0x52000000),
    inverseSurface: Color(0xFF1E1E1E),
    onInverseSurface: Color(0xFFF5F5F5),
    inversePrimary: AppColorTokens.primaryLight,
    surfaceTint: AppColorTokens.primary,
    surfaceContainerHighest: AppColorTokens.lightSurfaceContainer,
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFF8AAF),
    onPrimary: Color(0xFF5E112E),
    primaryContainer: Color(0xFF7D1C42),
    onPrimaryContainer: Color(0xFFFFD9E2),
    secondary: AppColorTokens.darkTextMuted,
    onSecondary: Color(0xFF1A1A1A),
    secondaryContainer: Color(0xFF202020),
    onSecondaryContainer: AppColorTokens.darkText,
    tertiary: Color(0xFFFFB1C8),
    onTertiary: Color(0xFF65142F),
    tertiaryContainer: Color(0xFF841E45),
    onTertiaryContainer: Color(0xFFFFD9E4),
    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),
    errorContainer: Color(0xFF8C1D18),
    onErrorContainer: Color(0xFFF9DEDC),
    surface: AppColorTokens.darkSurface,
    onSurface: AppColorTokens.darkText,
    onSurfaceVariant: AppColorTokens.darkTextMuted,
    outline: AppColorTokens.darkBorder,
    outlineVariant: Color(0xFF232323),
    shadow: Colors.black,
    scrim: Color(0x99000000),
    inverseSurface: Color(0xFFF5F5F5),
    onInverseSurface: Color(0xFF141414),
    inversePrimary: AppColorTokens.primaryDark,
    surfaceTint: Color(0xFFFF8AAF),
    surfaceContainerHighest: AppColorTokens.darkSurfaceContainer,
  );
}
