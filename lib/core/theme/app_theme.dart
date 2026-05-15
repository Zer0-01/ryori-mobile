// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:ryori/core/theme/app_app_bar_theme.dart';
import 'package:ryori/core/theme/app_bottom_sheet_theme.dart';
import 'package:ryori/core/theme/app_button_theme.dart';
import 'package:ryori/core/theme/app_card_theme.dart';
import 'package:ryori/core/theme/app_color_scheme.dart';
import 'package:ryori/core/theme/app_dialog_theme.dart';
import 'package:ryori/core/theme/app_floating_action_button_theme.dart';
import 'package:ryori/core/theme/app_input_decoration_theme.dart';
import 'package:ryori/core/theme/app_list_tile_theme.dart';

class AppTheme {
  const AppTheme._();

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: AppColorSchemeTokens.light,
    appBarTheme: AppAppBarTheme.light,
    inputDecorationTheme: AppInputDecorationTheme.light,
    cardTheme: AppCardTheme.light,
    floatingActionButtonTheme: AppFloatingActionButtonTheme.light,
    dialogTheme: AppDialogTheme.light,
    bottomSheetTheme: AppBottomSheetTheme.light,
    listTileTheme: AppListTileTheme.light,
    filledButtonTheme: AppFilledButtonTheme.light,
    outlinedButtonTheme: AppOutlinedButtonTheme.light,
    textButtonTheme: AppTextButtonTheme.light,
    elevatedButtonTheme: AppElevatedButtonTheme.light,
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: AppColorSchemeTokens.dark,
    appBarTheme: AppAppBarTheme.dark,
    inputDecorationTheme: AppInputDecorationTheme.dark,
    cardTheme: AppCardTheme.dark,
    floatingActionButtonTheme: AppFloatingActionButtonTheme.dark,
    dialogTheme: AppDialogTheme.dark,
    bottomSheetTheme: AppBottomSheetTheme.dark,
    listTileTheme: AppListTileTheme.dark,
    filledButtonTheme: AppFilledButtonTheme.dark,
    outlinedButtonTheme: AppOutlinedButtonTheme.dark,
    textButtonTheme: AppTextButtonTheme.dark,
    elevatedButtonTheme: AppElevatedButtonTheme.dark,
  );
}
