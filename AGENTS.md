# AGENTS.md

## Cursor Cloud specific instructions

`manifesto` is a Flutter mobile/web app (GetX + Clean Architecture). It is a frontend
client only; it talks to an external REST backend via the `BASE_URL` in `.env`.
There is no backend in this repo.

### Toolchain
- Flutter is installed at `/opt/flutter` and is on `PATH` (added via `~/.bashrc`).
  Verify with `flutter --version` (stable, Dart >= 3.10 required by `pubspec.lock`).
- Standard commands: `flutter pub get`, `flutter analyze` (lint),
  `flutter test`, `flutter run`.

### `.env` is required (git-ignored)
- `main.dart` calls `dotenv.load(fileName: ".env")`, so a `.env` file MUST exist at
  the repo root or the app crashes on startup. `.env` is git-ignored (`*.env`), so it
  is NOT restored by cloning — the update script recreates a default one if missing.
- The only key read is `BASE_URL` (see `dio_client.dart`). Point it at the backend,
  e.g. `BASE_URL=https://fambot-backend-g1gu.onrender.com`. That backend is on
  Render's free tier and cold-starts (first request can take ~40s).
- `.env` is bundled as a Flutter asset, so after editing it you must fully restart
  `flutter run` (a hot reload/restart does not re-bundle assets).

### Running the app (web is the easiest target in the cloud VM)
- Chrome is installed. Run headless-friendly:
  `flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0`
  then open `http://localhost:8080` (the `computerUse` browser can reach it).
- The app boots on the Signup page (`AppPages.initial = signup`). Signup ->
  Onboarding -> Dashboard (which has the chatbot tab).

### Known gotchas
- The single test `test/widget_test.dart` is stale default scaffolding (a counter
  smoke test) and does not match this app, so `flutter test` fails on it. This is
  pre-existing and unrelated to the environment.
- This codebase was developed on macOS (case-insensitive FS). On Linux (case-sensitive)
  watch for import path bugs that macOS tolerates: wrong-case package imports (e.g.
  `package:get/Get.dart` instead of `get/get.dart`) and duplicated slashes in import
  URIs (e.g. `common//resources/...`). These pass `flutter analyze` (the analyzer
  normalizes them) but break the web DDC build at runtime with "Library not defined".
