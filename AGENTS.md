# Repository Guidelines

## Core Rules
1. Follow the current project design and architecture by default.
2. If a better approach or improvement is identified, stop and ask for approval before changing the established architecture or design direction.
3. Do not make assumptions. If something is missing, ambiguous, or not confirmed in the codebase or request, ask first.
4. Ask for clarification and explicit verification whenever requirements, expected behavior, or technical direction are unclear.
5. Before implementation, clarify any uncertainty about field structure, data types, storage format, or validation rules instead of inferring them.
5. Make sure changes have no or low potential for bugs and code smells.
6. Prefer best practices and keep code maintainable, scalable, and readable.
7. Must follow the project design token system.

## Execution Constraints
1. Do not create tests unless explicitly requested.
2. Do not run tests, analyzers, or verification commands unless explicitly requested.
3. Do not run any command unless explicitly instructed to do so, or unless approval is requested and confirmed first.
4. Ask for approval before proceeding with command execution when command use is needed.
5. Any Flutter or Dart command must be run through `fvm`, for example `fvm flutter ...` and `fvm dart ...`.
6. Do not update generated files by hand or manually. Ask for approval before running the command that regenerates them.
7. Keep changes scoped to the requested task. Do not introduce unrelated refactors or cleanup.
8. Prefer working with the existing structure, naming, and patterns already present in this repository.

## Working Style
1. Be explicit, direct, and verification-oriented.
2. Surface uncertainties early instead of filling gaps with guesses.
3. When blocked by missing information, ask concise questions and wait for confirmation.
