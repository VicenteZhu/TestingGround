#!/bin/bash
# Build all projects
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

echo "=== Building React Native iOS ==="
cd "$ROOT_DIR/apps/react-native/ios"
xcodebuild -workspace TestingGround.xcworkspace -scheme TestingGround \
  -configuration Debug -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -derivedDataPath ./dist build

echo ""
echo "=== Building iOS Native ==="
cd "$ROOT_DIR/apps/ios-native"
xcodebuild -project TestingGround.xcodeproj -scheme TestingGround \
  -configuration Debug -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build

echo ""
echo "=== All builds completed ==="
