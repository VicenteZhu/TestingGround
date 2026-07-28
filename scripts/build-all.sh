#!/bin/bash
# Build all projects — standalone (offline, no Metro required)
# Outputs to root dist/ directory
#
# Usage:
#   ./scripts/build-all.sh          # Build all platforms
#   ./scripts/build-all.sh ios      # Build iOS only
#   ./scripts/build-all.sh android  # Build Android only
#   ./scripts/build-all.sh web      # Build Web only
#   ./scripts/build-all.sh ios-native  # Build iOS native only
#   ./scripts/build-all.sh all      # Build all (same as no argument)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
RN_DIR="$ROOT_DIR/apps/react-native"
IOS_NATIVE_DIR="$ROOT_DIR/apps/ios-native"
DIST_DIR="$ROOT_DIR/dist"

TARGET="${1:-all}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_step() { echo -e "\n${YELLOW}=== $1 ===${NC}"; }
log_ok()   { echo -e "${GREEN}✓ $1${NC}"; }
log_err()  { echo -e "${RED}✗ $1${NC}"; }

build_ios() {
  log_step "Generating iOS offline JS bundle"
  cd "$RN_DIR"
  npx react-native bundle \
    --platform ios --dev false \
    --entry-file index.js \
    --bundle-output ios/main.jsbundle \
    --assets-dest ios/ 2>&1 | tail -3
  log_ok "iOS bundle generated"

  log_step "Building RN iOS app (standalone)"
  cd "$RN_DIR/ios"
  xcodebuild -workspace TestingGround.xcworkspace -scheme TestingGround \
    -configuration Debug -sdk iphonesimulator \
    -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
    -derivedDataPath ./dist-build build 2>&1 | grep -E "BUILD" | tail -1

  mkdir -p "$DIST_DIR/ios"
  cp -r dist-build/Build/Products/Debug-iphonesimulator/TestingGround.app "$DIST_DIR/ios/"
  rm -rf dist-build
  rm -f "$RN_DIR/ios/main.jsbundle"
  log_ok "iOS app → dist/ios/TestingGround.app"
}

build_android() {
  log_step "Generating Android offline JS bundle"
  cd "$RN_DIR"
  mkdir -p android/app/src/main/assets
  npx react-native bundle \
    --platform android --dev false \
    --entry-file index.js \
    --bundle-output android/app/src/main/assets/index.android.bundle \
    --assets-dest android/app/src/main/res/ 2>&1 | tail -3
  log_ok "Android bundle generated"

  log_step "Building RN Android app (standalone, Release)"
  cd "$RN_DIR/android"
  ANDROID_HOME="${ANDROID_HOME:-$HOME/Library/Android/sdk}" ./gradlew assembleRelease 2>&1 | tail -3

  mkdir -p "$DIST_DIR/android"
  cp app/build/outputs/apk/release/app-release.apk "$DIST_DIR/android/"
  rm -f "$RN_DIR/android/app/src/main/assets/index.android.bundle"
  log_ok "Android APK → dist/android/app-release.apk"
}

build_web() {
  log_step "Building Web production bundle"
  cd "$RN_DIR/web"
  npm run build 2>&1 | tail -3

  mkdir -p "$DIST_DIR/web"
  cp -r dist/* "$DIST_DIR/web/"
  log_ok "Web → dist/web/"
}

build_ios_native() {
  log_step "Building iOS Native app"
  cd "$IOS_NATIVE_DIR"
  xcodebuild -project TestingGround.xcodeproj -scheme TestingGround \
    -configuration Debug -sdk iphonesimulator \
    -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build 2>&1 | grep -E "BUILD" | tail -1

  mkdir -p "$DIST_DIR/ios-native"
  NATIVE_APP=$(find ~/Library/Developer/Xcode/DerivedData \
    -path "*/Debug-iphonesimulator/TestingGround.app" -newer project.yml 2>/dev/null | head -1)
  if [ -n "$NATIVE_APP" ]; then
    cp -r "$NATIVE_APP" "$DIST_DIR/ios-native/"
    log_ok "iOS Native → dist/ios-native/TestingGround.app"
  else
    log_err "iOS Native .app not found in DerivedData"
    exit 1
  fi
}

# Create dist directory
mkdir -p "$DIST_DIR"

case "$TARGET" in
  ios)
    build_ios
    ;;
  android)
    build_android
    ;;
  web)
    build_web
    ;;
  ios-native)
    build_ios_native
    ;;
  all)
    build_ios
    build_android
    build_web
    build_ios_native
    ;;
  *)
    echo "Usage: $0 [all|ios|android|web|ios-native]"
    exit 1
    ;;
esac

echo ""
log_step "Build Summary"
echo "Output directory: $DIST_DIR"
if [ -d "$DIST_DIR/ios" ]; then
  echo "  ios/         $(du -sh "$DIST_DIR/ios" | cut -f1)"
fi
if [ -d "$DIST_DIR/android" ]; then
  echo "  android/     $(du -sh "$DIST_DIR/android" | cut -f1)"
fi
if [ -d "$DIST_DIR/web" ]; then
  echo "  web/         $(du -sh "$DIST_DIR/web" | cut -f1)"
fi
if [ -d "$DIST_DIR/ios-native" ]; then
  echo "  ios-native/  $(du -sh "$DIST_DIR/ios-native" | cut -f1)"
fi
log_ok "All requested builds completed"
