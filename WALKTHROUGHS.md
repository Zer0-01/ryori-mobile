Updated `AppLogger` to be a plain class instead of an Injectable/GetIt singleton.

Changed `AppLogger` to accept an optional `tag` parameter and use that tag in log message formatting.

Removed the redundant `scoped()` helper since tagged loggers are now created directly with `AppLogger(tag: ...)`.

Updated `HomeViewModel` to construct its own tagged logger locally with `AppLogger(tag: 'HomeViewModel')` instead of receiving a logger from DI.

Adjusted the generated DI config to remove `AppLogger` registration and the `HomeViewModel` logger dependency so the current code stays aligned without introducing broader refactors.

Introduced explicit color design tokens in `AppTheme` for a minimalist pink theme direction, with white light backgrounds and black dark backgrounds.

Replaced direct `ColorScheme.fromSeed` usage with explicit light and dark `ColorScheme` definitions to make the application theme more maintainable and scalable.

Extracted color tokens and color scheme definitions into a separate theme file so `AppTheme` stays focused on composing `ThemeData`.

Updated `App` so the `AdaptiveTheme` builder passes the resolved `theme` and `darkTheme` into `MaterialApp.router`, ensuring the configured theme is actually applied.

Enhanced the empty state in `RecipesListWidget` only, while preserving the existing `Consumer` and status-branching pattern. The empty UI now uses the theme color scheme for a more polished, readable card-style presentation.

Added app bar design tokens in a dedicated theme file, with minimalist values for background, foreground, title style, spacing, and flat elevation behavior in both light and dark themes.

Updated the `getRecipes()` flow to map Drift `Recipe` query rows into `RecipesResponseDto` at the local data source boundary, then propagated that DTO type through the repository, use case, and home view model.

Added input decoration design tokens in `AppTheme`, covering shared sizing, padding, typography, fill, and border states for both light and dark themes.

Added dedicated design tokens for `FilledButton`, `OutlinedButton`, `TextButton`, and `ElevatedButton` in `AppTheme`, then wired those theme definitions into the light and dark `ThemeData` without changing any unrelated theme architecture.

Moved the input decoration and button theme token implementations out of `AppTheme` into separate theme files so the main theme file stays focused on composing `ThemeData`.

Created the recipe name form UI in the add-recipe flow by replacing the placeholder with a themed `TextFormField` and adding form padding so the field sits correctly within the scrollable layout.

Added the recipe description field UI as a multiline themed `TextFormField` and placed it beneath the recipe name field with consistent spacing in the add-recipe form.

Added a local asset-backed recipe types source by creating `asset/json/recipetypes.json`, registering it in `pubspec.yaml`, and adding a `getTypes()` loader in the add-recipe local data source that decodes the JSON into `TypeResponseDto`.

Replaced the placeholder in `RecipeTypeFormWidget` with a read-only themed `TextFormField` that can be tapped, exposes an optional `onTap` callback for later wiring, and currently falls back to a no-op placeholder handler.

Added dedicated modal design tokens for dialogs and bottom sheets in a separate theme file, then wired those themed values into `AppTheme` so both light and dark `ThemeData` consistently style modal surfaces without changing the broader theme architecture.

Split the shared modal theme file into `app_dialog_theme.dart` and `app_bottom_sheet_theme.dart` so each themed component now has its own dedicated token file, matching the existing theme organization more closely.

Added a dedicated `app_list_tile_theme.dart` token file and registered `ListTileThemeData` in `AppTheme` so list tiles now use centralized spacing, typography, shape, and selection surface tokens in both light and dark themes.

Completed `AddRecipeLocalDataSource.postRecipe()` by wiring it to `AppDatabase`, inserting a real `RecipesCompanion` row instead of returning a dummy value, and resolving the saved recipe's type response from the local recipe types source.

Finished the add-recipe save wiring by passing an `AddRecipeRequestDto` from the button through the view model and use case into the repository/local data source path, so the form controller values now drive the actual save operation.

Added a dedicated `app_card_theme.dart` token file and registered `cardTheme` in `AppTheme` so cards now use centralized surface, border, radius, and elevation tokens in both light and dark themes.

Added a dedicated `app_floating_action_button_theme.dart` token file and registered `floatingActionButtonTheme` in `AppTheme` so floating action buttons now use centralized color, elevation, and extended-label typography tokens in both light and dark themes.

Completed the recipe-detail data layer by wiring `RecipeDetailLocalDataSource` to `AppDatabase`, querying a single recipe row by `uuid`, mapping it into `RecipeDetailResponseDto`, and keeping the repository implementation as a thin pass-through to that local source.
