// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:ryori/features/addrecipe/presentation/views/add_recipe_setup.dart'
    as _i1;
import 'package:ryori/features/editrecipe/presentation/views/edit_recipe_setup.dart'
    as _i2;
import 'package:ryori/features/home/presentation/views/home_setup.dart' as _i3;
import 'package:ryori/features/login/presentation/views/login_setup.dart'
    as _i4;
import 'package:ryori/features/recipedetail/presentation/views/recipe_detail_setup.dart'
    as _i5;
import 'package:ryori/features/register/presentation/views/register_setup.dart'
    as _i6;
import 'package:ryori/features/startup/presentation/views/startup_setup.dart'
    as _i7;

/// generated route for
/// [_i1.AddRecipeSetup]
class AddRecipeSetup extends _i8.PageRouteInfo<void> {
  const AddRecipeSetup({List<_i8.PageRouteInfo>? children})
    : super(AddRecipeSetup.name, initialChildren: children);

  static const String name = 'AddRecipeSetup';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddRecipeSetup();
    },
  );
}

/// generated route for
/// [_i2.EditRecipeSetup]
class EditRecipeSetup extends _i8.PageRouteInfo<EditRecipeSetupArgs> {
  EditRecipeSetup({
    _i9.Key? key,
    required String recipeId,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         EditRecipeSetup.name,
         args: EditRecipeSetupArgs(key: key, recipeId: recipeId),
         initialChildren: children,
       );

  static const String name = 'EditRecipeSetup';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditRecipeSetupArgs>();
      return _i2.EditRecipeSetup(key: args.key, recipeId: args.recipeId);
    },
  );
}

class EditRecipeSetupArgs {
  const EditRecipeSetupArgs({this.key, required this.recipeId});

  final _i9.Key? key;

  final String recipeId;

  @override
  String toString() {
    return 'EditRecipeSetupArgs{key: $key, recipeId: $recipeId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditRecipeSetupArgs) return false;
    return key == other.key && recipeId == other.recipeId;
  }

  @override
  int get hashCode => key.hashCode ^ recipeId.hashCode;
}

/// generated route for
/// [_i3.HomeSetup]
class HomeSetup extends _i8.PageRouteInfo<void> {
  const HomeSetup({List<_i8.PageRouteInfo>? children})
    : super(HomeSetup.name, initialChildren: children);

  static const String name = 'HomeSetup';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeSetup();
    },
  );
}

/// generated route for
/// [_i4.LoginSetup]
class LoginSetup extends _i8.PageRouteInfo<void> {
  const LoginSetup({List<_i8.PageRouteInfo>? children})
    : super(LoginSetup.name, initialChildren: children);

  static const String name = 'LoginSetup';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoginSetup();
    },
  );
}

/// generated route for
/// [_i5.RecipeDetailSetup]
class RecipeDetailSetup extends _i8.PageRouteInfo<RecipeDetailSetupArgs> {
  RecipeDetailSetup({
    _i9.Key? key,
    required String recipeId,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         RecipeDetailSetup.name,
         args: RecipeDetailSetupArgs(key: key, recipeId: recipeId),
         initialChildren: children,
       );

  static const String name = 'RecipeDetailSetup';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RecipeDetailSetupArgs>();
      return _i5.RecipeDetailSetup(key: args.key, recipeId: args.recipeId);
    },
  );
}

class RecipeDetailSetupArgs {
  const RecipeDetailSetupArgs({this.key, required this.recipeId});

  final _i9.Key? key;

  final String recipeId;

  @override
  String toString() {
    return 'RecipeDetailSetupArgs{key: $key, recipeId: $recipeId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RecipeDetailSetupArgs) return false;
    return key == other.key && recipeId == other.recipeId;
  }

  @override
  int get hashCode => key.hashCode ^ recipeId.hashCode;
}

/// generated route for
/// [_i6.RegisterSetup]
class RegisterSetup extends _i8.PageRouteInfo<void> {
  const RegisterSetup({List<_i8.PageRouteInfo>? children})
    : super(RegisterSetup.name, initialChildren: children);

  static const String name = 'RegisterSetup';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.RegisterSetup();
    },
  );
}

/// generated route for
/// [_i7.StartupSetup]
class StartupSetup extends _i8.PageRouteInfo<void> {
  const StartupSetup({List<_i8.PageRouteInfo>? children})
    : super(StartupSetup.name, initialChildren: children);

  static const String name = 'StartupSetup';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.StartupSetup();
    },
  );
}
