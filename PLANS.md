Focus: generate design tokens for the application theme, limited to color scheme work in `lib/app/app.dart` and `lib/core/theme/app_theme.dart`.

Plan:

1. Introduce a dedicated color token layer in the theme module.
Create explicit application color tokens instead of relying directly on `ColorScheme.fromSeed`, so the app has a stable and readable source of truth for brand and surface colors.

2. Map the color tokens into light and dark `ColorScheme` definitions.
Define both schemes explicitly to improve maintainability and make future theme expansion predictable.

3. Update `AppTheme` to build `ThemeData` from the tokenized color schemes.
Keep the change scoped to color design tokens only, without introducing typography, spacing, or component theme refactors.

4. Keep `App` integration minimal.
Only adjust `lib/app/app.dart` if needed to consume the updated theme API while preserving the current `AdaptiveTheme` setup.

Notes:
- Scope remains limited to color scheme tokens only.
- No tests or analyzers will be run unless explicitly requested.
- I will preserve the existing architecture and avoid unrelated theme refactors.
