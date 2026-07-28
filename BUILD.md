# Build Guide / 构建教程

Complete guide for setting up the development environment and building both sub-projects.

[Back to README](README.md) | [中文文档](README_CN.md)

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Environment Setup](#environment-setup)
  - [1. Node.js & npm](#1-nodejs--npm)
  - [2. JDK 17](#2-jdk-17)
  - [3. Watchman](#3-watchman)
  - [4. Ruby & CocoaPods](#4-ruby--cocoapods)
  - [5. XcodeGen](#5-xcodegen)
  - [6. Android Studio & SDK](#6-android-studio--sdk)
  - [7. Xcode](#7-xcode)
  - [8. Verify Installation](#8-verify-installation)
- [Building the React Native App](#building-the-react-native-app)
  - [iOS](#ios)
  - [Android](#android)
  - [Web](#web)
- [Building the iOS Native App](#building-the-ios-native-app)
- [Shared Scripts](#shared-scripts)
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

Install via nvm (recommended):

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.zshrc
nvm install 22
nvm use 22
node --version   # v22.x
npm --version    # 10.x
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
java -version    # openjdk 17.x
```

### 3. Watchman

```bash
brew install watchman
watchman --version
```

### 4. Ruby & CocoaPods

macOS system Ruby may be too old. Install via Homebrew:

```bash
brew install ruby
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
ruby --version   # 3.x
```

Install CocoaPods:

```bash
sudo gem install cocoapods
pod --version
```

If `pod` is not found, add the Ruby gems bin to PATH:

```bash
echo 'export PATH="/usr/local/lib/ruby/gems/$(ruby -e "puts Gem.ruby_version")/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 5. XcodeGen

Required for the iOS native project (`apps/ios-native/`):

```bash
brew install xcodegen
xcodegen --version
```

### 6. Android Studio & SDK

1. Download from [developer.android.com/studio](https://developer.android.com/studio)
2. After first launch, open **SDK Manager** and install:
   - **SDK Platforms**: Android 15.0 (API 35) or higher
   - **SDK Tools**: Android SDK Build-Tools, Android Emulator, Android SDK Platform-Tools
   - **System Image**: Intel x86_64 System Image (API 35)

3. Configure environment variables:

```bash
echo 'export ANDROID_HOME="$HOME/Library/Android/sdk"' >> ~/.zshrc
echo 'export ANDROID_SDK_ROOT="$ANDROID_HOME"' >> ~/.zshrc
echo 'export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

4. Create an Android emulator (optional):

```bash
sdkmanager "system-images;android-35;google_apis;x86_64"
avdmanager create avd -n Pixel_10_Pro_XL -k "system-images;android-35;google_apis;x86_64" -d "pixel_10_pro_xl"
```

### 7. Xcode

Install from Mac App Store. After installation, launch once to accept the license, then:

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
xcodebuild -version    # Xcode 16.x
```

### 8. Verify Installation

Run all checks at once:

```bash
echo "=== Environment Check ==="
node --version          # v22.x
npm --version           # 10.x
java -version           # openjdk 17.x
watchman --version      # v20xx
pod --version           # 1.x
xcodegen --version      # 2.x
xcodebuild -version     # Xcode 16.x
adb --version           # Android Debug Bridge
emulator -list-avds     # List available AVDs
xcrun simctl list devices available | grep iPhone | head -5
```

---

## Building the React Native App

All commands below run from `apps/react-native/`:

```bash
cd apps/react-native
```

### First-time setup

```bash
npm install
cd ios && pod install && cd ..
```

### iOS

```bash
# Start Metro dev server (keep running)
npm start

# In a new terminal — build and run on simulator
npm run ios

# Or build with explicit xcodebuild (output to ios/dist/)
cd ios && xcodebuild -workspace TestingGround.xcworkspace -scheme TestingGround \
  -configuration Debug -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -derivedDataPath ./dist build
```

**TypeScript check** (no build required):

```bash
npx tsc --noEmit
```

### Android

```bash
# Start the emulator first
$ANDROID_HOME/emulator/emulator -avd Pixel_10_Pro_XL &

# Wait for emulator to boot, then build and install
npm run android

# Or using react-native CLI
npx react-native run-android --mode=debug
```

> First Android build takes ~5-10 minutes. Subsequent incremental builds take ~1 minute.

### Web

```bash
# Dev server (localhost:3000)
npm run web

# Production build (outputs to web/dist/)
npm run web-build
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

This reads `project.yml` and generates `TestingGround.xcodeproj`.

### Build with command line

```bash
xcodebuild -project TestingGround.xcodeproj -scheme TestingGround \
  -configuration Debug -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
```

### Build and run

```bash
# Boot simulator
xcrun simctl boot "iPhone 17 Pro"
open -a Simulator

# Install and launch
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

## Shared Scripts

### Build all iOS apps

```bash
./scripts/build-all.sh
```

This script builds both the React Native iOS app and the iOS native app in sequence.

---

## Troubleshooting

### iOS: `React-VFS.yaml` not found

**Symptom**: `virtual filesystem overlay file '/.../React-Core-prebuilt/React-VFS.yaml' not found`

**Cause**: CocoaPods cached old absolute paths (common after moving the project directory).

**Fix**:

```bash
cd apps/react-native/ios
pod install
```

### Android: Gradle `projectDirectory does not exist`

**Symptom**: `Configuring project ':react-native-safe-area-context' without an existing directory is not allowed`

**Cause**: Gradle `.gradle/` cache contains stale absolute paths to `node_modules`.

**Fix**:

```bash
cd apps/react-native/android
rm -rf .gradle build
# Then rebuild
cd ..
npx react-native run-android
```

### Android: Metro bundler not connecting

**Symptom**: App shows blank screen or "Unable to load script" on Android.

**Fix**:

```bash
# Ensure Metro is running
cd apps/react-native
npm start

# In another terminal, trigger reload on the emulator
# Press 'R' twice in Metro terminal, or:
$ANDROID_HOME/platform-tools/adb shell input text "RR"
```

### iOS: "No script URL provided"

**Symptom**: Red error screen: `No script URL provided. Make sure the packager is running.`

**Cause**: App was launched via `xcrun simctl launch` instead of `react-native run-ios`, so it doesn't know the Metro server URL.

**Fix**:

```bash
# Use react-native CLI to launch (it configures Metro connection)
cd apps/react-native
npx react-native run-ios --simulator="iPhone 17 Pro"
```

Or if the app is already running, trigger a reload:

```bash
curl http://localhost:8081/reload
```

### TypeScript errors in `web/` directory

**Symptom**: `Cannot find name 'document'` errors in `web/src/*.tsx` files.

**Cause**: Root `tsconfig.json` was including web files that need DOM types.

**Fix**: Already handled — `web` is excluded in `apps/react-native/tsconfig.json`.
