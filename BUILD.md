# Build Guide / 构建教程

Complete guide for setting up the development environment and building all sub-projects. Supports both **development mode** (with Metro hot-reload) and **standalone mode** (offline, no Metro required).

[Back to README](README.md) | [中文文档](README_CN.md)

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Environment Setup](#environment-setup)
- [Build Modes Overview](#build-modes-overview)
- [Development Build (with Metro)](#development-build-with-metro)
  - [iOS](#ios-dev)
  - [Android](#android-dev)
  - [Web](#web-dev)
- [Standalone Build (without Metro)](#standalone-build-without-metro)
  - [Generate Offline JS Bundle](#step-1-generate-offline-js-bundle)
  - [iOS Standalone](#ios-standalone)
  - [Android Standalone](#android-standalone)
  - [Web Standalone](#web-standalone)
- [Build All (one-command)](#build-all-one-command)
- [Building the iOS Native App](#building-the-ios-native-app)
- [Troubleshooting](#troubleshooting)

---

## Prerequisites

| Tool | Min Version | Platform | Purpose |
|------|------------|----------|---------|
| Node.js | 22.11 | All | Runtime for RN & tooling |
| npm | 10 | All | Package manager |
| JDK | 17 | Android | Android build |
| Xcode | 16+ | macOS | iOS build |
| CocoaPods | latest | macOS | iOS dependency manager |
| XcodeGen | latest | macOS | iOS native project generation |
| Android Studio | latest | All | Android IDE & SDK |
| Watchman | latest | macOS | File watcher |

---

## Environment Setup

### 1. Node.js & npm

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.zshrc
nvm install 22
nvm use 22
```

**npm cache fix**: If your system npm cache has root-owned files:

```bash
npm config set cache $HOME/workspace/.npm-cache
```

### 2. JDK 17

```bash
brew install openjdk@17
echo 'export JAVA_HOME="/usr/local/opt/openjdk@17"' >> ~/.zshrc
source ~/.zshrc
```

### 3. Watchman

```bash
brew install watchman
```

### 4. Ruby & CocoaPods

```bash
brew install ruby
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
sudo gem install cocoapods
```

### 5. XcodeGen

```bash
brew install xcodegen
```

### 6. Android Studio & SDK

1. Download from [developer.android.com/studio](https://developer.android.com/studio)
2. Install via SDK Manager: Android 15.0 (API 35), Build-Tools, Emulator, Platform-Tools
3. Configure:

```bash
echo 'export ANDROID_HOME="$HOME/Library/Android/sdk"' >> ~/.zshrc
echo 'export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

4. Create emulator (optional):

```bash
sdkmanager "system-images;android-35;google_apis;x86_64"
avdmanager create avd -n Pixel_10_Pro_XL -k "system-images;android-35;google_apis;x86_64" -d "pixel_10_pro_xl"
```

### 7. Xcode

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

### 8. Verify

```bash
node --version && npm --version && java -version && pod --version && xcodegen --version && adb --version
```

---

## Build Modes Overview

| Mode | Metro Required | Hot Reload | Use Case |
|------|---------------|------------|----------|
| **Development** | Yes | Yes | Active development, debugging |
| **Standalone** | No | No | CI/CD, testing, distribution |

All commands below run from `apps/react-native/`:

```bash
cd apps/react-native
```

### First-time setup (both modes)

```bash
npm install
cd ios && pod install && cd ..
```

---

## Development Build (with Metro)

Apps connect to Metro dev server for live JS bundle serving and hot-reload.

### iOS {#ios-dev}

```bash
# Terminal 1 — Start Metro
npm start

# Terminal 2 — Build & launch
npm run ios
```

Or with explicit xcodebuild:

```bash
cd ios && xcodebuild -workspace TestingGround.xcworkspace -scheme TestingGround \
  -configuration Debug -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -derivedDataPath ./dist build
```

### Android {#android-dev}

```bash
# Terminal 1 — Start Metro
npm start

# Terminal 2 — Start emulator & build
$ANDROID_HOME/emulator/emulator -avd Pixel_10_Pro_XL &
npm run android
```

### Web {#web-dev}

```bash
npm run web    # Dev server at localhost:3000
```

**TypeScript check** (no build required):

```bash
npx tsc --noEmit
```

---

## Standalone Build (without Metro)

Apps are pre-bundled with the JS code embedded, so they run independently without Metro.

### Step 1: Generate Offline JS Bundle

This creates a production-ready JS bundle for each platform:

```bash
cd apps/react-native

# iOS bundle
npx react-native bundle \
  --platform ios --dev false \
  --entry-file index.js \
  --bundle-output ios/main.jsbundle \
  --assets-dest ios/

# Android bundle
mkdir -p android/app/src/main/assets
npx react-native bundle \
  --platform android --dev false \
  --entry-file index.js \
  --bundle-output android/app/src/main/assets/index.android.bundle \
  --assets-dest android/app/src/main/res/
```

### Step 2: Build Each Platform

#### iOS Standalone

> **Important**: In Debug mode, Xcode's "Bundle React Native code and images" build phase does NOT embed
> the JS bundle into the `.app`. You must manually inject the pre-built `main.jsbundle` after building.

```bash
cd apps/react-native/ios

xcodebuild -workspace TestingGround.xcworkspace -scheme TestingGround \
  -configuration Debug -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -derivedDataPath ./dist-build build

APP_DIR="dist-build/Build/Products/Debug-iphonesimulator/TestingGround.app"

# Inject offline bundle into .app (critical step)
cp ../main.jsbundle "$APP_DIR/main.jsbundle"

# Copy .app to dist/
mkdir -p ../../../../dist/ios
cp -r "$APP_DIR" ../../../../dist/ios/
rm -rf dist-build
```

The injected `main.jsbundle` is used when the app cannot connect to Metro, enabling fully offline operation.

#### Android Standalone

```bash
cd apps/react-native/android

ANDROID_HOME=$HOME/Library/Android/sdk ./gradlew assembleRelease

# Copy APK to dist/
mkdir -p ../../../../dist/android
cp app/build/outputs/apk/release/app-release.apk ../../../../dist/android/
```

The Release APK automatically includes the embedded `index.android.bundle` from `assets/`.

#### Web Standalone

```bash
cd apps/react-native/web
npm run build

# Copy to dist/
mkdir -p ../../../../dist/web
cp -r dist/* ../../../../dist/web/
```

Serve with any static HTTP server:

```bash
cd dist/web
python3 -m http.server 3000
# or
npx serve .
```

### Output Structure

```
dist/
├── ios/TestingGround.app     (~83 MB)   Standalone iOS app
├── android/app-release.apk   (~59 MB)   Standalone Android APK
└── web/                                 Static web build (~252 KB)
    ├── index.html
    └── assets/
```

---

## Build All (one-command)

### Standalone build (all platforms to dist/)

```bash
./scripts/build-all.sh
```

This script:
1. Generates offline JS bundles for iOS and Android
2. Builds iOS .app (Debug, with embedded bundle)
3. Builds Android Release APK (with embedded bundle)
4. Builds Web production bundle
5. Copies everything to `dist/`

### Build specific targets

```bash
# iOS only
./scripts/build-all.sh ios

# Android only
./scripts/build-all.sh android

# Web only
./scripts/build-all.sh web

# iOS Native only
./scripts/build-all.sh ios-native

# All (default)
./scripts/build-all.sh all
```

---

## Building the iOS Native App

All commands below run from `apps/ios-native/`:

```bash
cd apps/ios-native
```

### Generate Xcode project (if needed)

```bash
xcodegen generate
```

### Build

```bash
xcodebuild -project TestingGround.xcodeproj -scheme TestingGround \
  -configuration Debug -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
```

### Build and run

```bash
xcrun simctl boot "iPhone 17 Pro"
open -a Simulator

IOS_APP=$(find ~/Library/Developer/Xcode/DerivedData -path "*/Debug-iphonesimulator/TestingGround.app" -newer project.yml | head -1)
xcrun simctl install "iPhone 17 Pro" "$IOS_APP"
xcrun simctl launch "iPhone 17 Pro" com.testing.ground.TestingGround
```

### Run UI tests

```bash
xcodebuild test -project TestingGround.xcodeproj -scheme TestingGroundUITests \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'
```

---

## Troubleshooting

### iOS: `React-VFS.yaml` not found

**Symptom**: `virtual filesystem overlay file '/.../React-Core-prebuilt/React-VFS.yaml' not found`

**Fix**:

```bash
cd apps/react-native/ios
pod install
```

### iOS: `HERMES_CLI_PATH` points to wrong path

**Symptom**: Build fails with `hermesc: No such file or directory` at an incorrect path.

**Fix**: Clean Pods and reinstall:

```bash
cd apps/react-native/ios
rm -rf Pods "Local Podspecs"
pod install
```

### Android: Gradle `projectDirectory does not exist`

**Symptom**: `Configuring project ':react-native-safe-area-context' without an existing directory is not allowed`

**Fix**:

```bash
cd apps/react-native/android
rm -rf .gradle build
cd ..
npx react-native run-android
```

### iOS: "No script URL provided" (Development mode only)

**Symptom**: Red error screen when Metro is not running.

**Fix** (development mode): Use `react-native run-ios` instead of `xcrun simctl launch`.

**Fix** (standalone mode): Ensure the offline bundle was generated before building:

```bash
ls apps/react-native/ios/main.jsbundle  # should exist
```

### Android: Blank screen in standalone mode

**Symptom**: Release APK shows blank screen.

**Fix**: Ensure the offline bundle exists before building:

```bash
ls apps/react-native/android/app/src/main/assets/index.android.bundle  # should exist
```
