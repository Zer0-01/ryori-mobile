# Ryori

Ryori is a Flutter recipe application with authentication, profile access, and local recipe management. The project combines API-backed account flows with a local recipe database, using a feature-based structure, dependency injection, generated routing, and environment-specific entrypoints.

## Feature Snapshot

- User registration and login
- Startup auth check with route redirection
- Profile retrieval from configured API endpoints
- Recipe listing and recipe detail view
- Add, edit, and delete recipe flows
- Local recipe persistence with Drift
- Asset-backed recipe type loading
- Light and dark theme support with centralized design tokens

## Current Status

The app is currently split across local and remote data sources:

- Authentication and profile flows depend on configured API endpoints.
- Recipe CRUD is currently stored locally in the app database.
- Recipe types are loaded from `asset/json/recipetypes.json`.

This means the project already supports a realistic auth flow while recipe management remains local-first.

## Tech Stack

- Flutter
- Dart
- FVM for Flutter version management
- `get_it` and `injectable` for dependency injection
- `auto_route` for navigation
- `dio` for networking
- `drift` for local database storage
- `flutter_secure_storage` for auth token persistence
- `envied` for environment-specific configuration
- `adaptive_theme` for theme mode handling

## Project Structure

The codebase follows a feature-first structure with shared application and core layers:

- `lib/app`
  App bootstrap, DI setup, and router configuration
- `lib/core`
  Shared infrastructure such as environment config, database, auth, networking, theme, and utilities
- `lib/features`
  Feature modules like login, register, profile, recipes, recipe detail, add recipe, and edit recipe
- `asset`
  Static assets such as recipe types JSON, launcher images, and splash assets

## Prerequisites

- Flutter managed through FVM
- Flutter version `3.35.7`
- Dart SDK compatible with the project constraint in `pubspec.yaml`

## Environment Configuration

Ryori uses environment-specific classes backed by Envied-generated files.

Existing env files in the repository:

- `.env.local`
- `.env.development`

Required environment variables:

- `API_BASE_URL`
- `AUTH_REGISTER_ENDPOINT`
- `AUTH_LOGIN_ENDPOINT`
- `AUTH_REFRESH_ENDPOINT`
- `AUTH_LOGOUT_ENDPOINT`
- `PROFILE_ENDPOINT`

These values are consumed through:

- `lib/core/env/local/env_local.dart`
- `lib/core/env/development/env_development.dart`

## Entrypoints

The project includes multiple Flutter entrypoints:

- `lib/main.dart`
  Development environment bootstrap
- `lib/main_development.dart`
  Development environment bootstrap
- `lib/main_local.dart`
  Local environment bootstrap

Each entrypoint initializes Flutter, configures dependency injection, selects the environment, and launches `App`.

## Getting Started

Install dependencies:

```bash
fvm flutter pub get
```

Run the app with the default entrypoint:

```bash
fvm flutter run
```

Run the local environment explicitly:

```bash
fvm flutter run -t lib/main_local.dart
```

Run the development environment explicitly:

```bash
fvm flutter run -t lib/main_development.dart
```

## Code Generation

This project relies on generated files for routing, DI, database support, and environment access.

Common generators in this repo include:

- `auto_route_generator`
- `injectable_generator`
- `drift_dev`
- `envied_generator`

Regenerate files when changing annotated classes, routes, Drift schemas, or env definitions:

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

Do not manually edit generated files such as:

- `*.g.dart`
- `injection.config.dart`
- `app_router.gr.dart`

## Development Notes

- Use `fvm flutter ...` and `fvm dart ...` for project commands.
- Dependency injection is configured through `lib/app/di`.
- App navigation is configured through `lib/app/router/app_router.dart`.
- Startup routing checks for a stored access token before sending the user to login or home.
- Auth tokens are stored securely with `flutter_secure_storage`.
- Local recipe persistence is implemented through `AppDatabase`.

## Contributor Guidance

When extending the project:

- Follow the existing feature-first structure.
- Keep new theme changes aligned with the centralized theme token files in `lib/core/theme`.
- Prefer working through the existing DI, repository, and use case layers instead of bypassing them.
- Regenerate code instead of modifying generated files by hand.

## Notes

- `lib/main.dart` is still a valid app entrypoint and should not be deleted unless all run/build flows are intentionally moved to a different target.
- The repository currently includes a default widget test file, but this README does not define a testing workflow because that was not part of the requested scope.
