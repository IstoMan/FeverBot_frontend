#!/usr/bin/env bash
# Idempotent Cloud Agent bootstrap for the FeverBot Flutter app.
set -euo pipefail

FLUTTER_DIR="$HOME/flutter"
FLUTTER_CHANNEL="stable"

# 1. Install the Flutter SDK if it is not already present (e.g. on a cold VM
#    without a prebuilt snapshot). When booting from a snapshot that already
#    contains the SDK this branch is skipped.
if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  echo "==> Installing Flutter SDK ($FLUTTER_CHANNEL) into $FLUTTER_DIR"
  git clone --depth 1 --branch "$FLUTTER_CHANNEL" https://github.com/flutter/flutter.git "$FLUTTER_DIR"
else
  echo "==> Flutter SDK already present in $FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

# 2. Make Flutter available on PATH for future interactive shells / terminals.
PROFILE_LINE='export PATH="$HOME/flutter/bin:$PATH"'
if ! grep -qxF "$PROFILE_LINE" "$HOME/.bashrc" 2>/dev/null; then
  echo "$PROFILE_LINE" >> "$HOME/.bashrc"
fi

# 3. Warm up the tool and enable the web target (used for headless demos).
flutter config --enable-web --no-analytics >/dev/null
flutter precache --web >/dev/null

# 4. The app loads configuration from a git-ignored .env file at startup
#    (dotenv). Recreate it with a sensible default if it is missing so the
#    app can boot. Point BASE_URL at the real backend when one is available.
if [ ! -f ".env" ]; then
  echo "==> Creating default .env (set BASE_URL to your backend to enable live API calls)"
  echo "BASE_URL=https://api.feverbot.example.com" > .env
fi

# 5. Resolve Dart/Flutter package dependencies from the lockfile.
flutter pub get

echo "==> Environment ready. Flutter version:"
flutter --version
