# AGENTS.md

## Project

Monorepo containing two independent mobile testing target applications:

1. **React Native App** (`apps/react-native/`) — React Native 0.85.3 (bare CLI, not Expo) + TypeScript. Cross-platform (iOS + Android + Web) Appium automation testing target with 5 screens.
2. **iOS Native App** (`apps/ios-native/`) — Swift 5 / UIKit + SwiftUI. Native iOS UI automation testing target with 5 screens.

Both apps share the same purpose: serve as target applications for UI automation testing (Appium / XCTest / Selenium).

## Repository structure

```
TestingGround/
├── apps/
│   ├── react-native/       # React Native cross-platform app
│   │   ├── src/            # Screens & navigation
│   │   ├── ios/            # RN iOS native project
│   │   ├── android/        # RN Android native project
│   │   ├── web/            # Vite web build
│   │   └── package.json
│   └── ios-native/         # Native iOS app (UIKit + SwiftUI)
│       ├── UIKit/          # UIKit implementation
│       ├── SwiftUI/        # SwiftUI implementation
│       └── project.yml     # XcodeGen config
├── scripts/                # Shared build/CI scripts
├── AGENTS.md
└── .gitignore
```

## Key commands

### React Native app (run from `apps/react-native/`)

```bash
cd apps/react-native

# TypeScript check (fast, no build)
npx tsc --noEmit

# Metro dev server
npm start

# Run on device/emulator
npm run android
npm run ios

# Android debug APK build
cd android && ANDROID_HOME=$HOME/Library/Android/sdk ./gradlew assembleDebug

# iOS CocoaPods (required after any native dep change)
cd ios && pod install

# iOS simulator build
cd ios && xcodebuild -workspace TestingGround.xcworkspace -scheme TestingGround \
  -configuration Debug -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build

# iOS simulator build (output to ios/dist/)
cd ios && xcodebuild -workspace TestingGround.xcworkspace -scheme TestingGround \
  -configuration Debug -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -derivedDataPath ./dist build

# Web dev server
npm run web

# Web production build
npm run web-build
```

### iOS Native app (run from `apps/ios-native/`)

```bash
cd apps/ios-native

# Generate Xcode project (requires XcodeGen)
xcodegen generate

# Build with Xcode
xcodebuild -project TestingGround.xcodeproj -scheme TestingGround \
  -configuration Debug -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build

# Run UI tests
xcodebuild test -project TestingGround.xcodeproj -scheme TestingGroundUITests \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'
```

## npm cache quirk

System npm cache has root-owned files. Always use the custom cache:

```bash
npm config set cache $HOME/workspace/.npm-cache
```

## Architecture

### React Native app

```
App.tsx → src/navigation/AppNavigator.tsx (NativeStack v7)
  ├── LoginScreen    (initialRoute)  — admin/123456 hardcoded
  ├── HomeScreen                     — replace() to Login on logout
  ├── TodoListScreen
  ├── FormScreen
  └── CalculatorScreen
```

- `apps/react-native/src/screens/*.tsx` — all UI pages
- `apps/react-native/src/navigation/AppNavigator.tsx` — stack config
- Entry point: `index.js` → `App.tsx`

### iOS Native app

```
UIKit/App/AppDelegate.swift → MainTabBarController.swift
  ├── LoginViewController
  ├── FormTestViewController
  ├── ListTestViewController
  ├── AlertTestViewController
  └── SettingsViewController
```

- `apps/ios-native/UIKit/Views/*.swift` — UIKit view controllers
- `apps/ios-native/SwiftUI/Views/*.swift` — SwiftUI views (alternative implementation)
- XcodeGen config: `apps/ios-native/project.yml`

## Appium / accessibility contract

**Every interactive element must have both `accessibilityLabel` and `testID` set to the same value.** Appium uses `accessibility id` strategy which works cross-platform through these props.

When adding or modifying UI elements, follow the naming convention:
- React Native: `calcDigit_0`, `todoText_{i}` (see `apps/react-native/README.md`)
- iOS Native: `<page>_<element_type>_<name>` e.g. `login_username_textfield` (see `apps/ios-native/README.md`)

## Environment

- Node.js >= 22.11 (enforced in package.json engines)
- JDK 17 (`/usr/local/opt/openjdk@17`)
- ANDROID_HOME = `$HOME/Library/Android/sdk`
- iOS: Xcode 16+ with Simulator runtime 26.x
- CocoaPods installed via Ruby gems
- XcodeGen (for iOS native project generation)

## Code style

### React Native
- Prettier: single quotes, trailing commas, arrowParens avoid
- ESLint: `@react-native` config
- No explicit return types on React components (inferred)

### iOS Native
- Swift 5, iOS 14.0+ deployment target
- UIKit and SwiftUI dual implementations
- accessibilityIdentifier on all interactive elements
# AGENTS.md

## Project

React Native 0.85.3 (bare CLI, not Expo) + TypeScript. Built as an Appium automation testing target with 5 screens of standard UI controls. iOS + Android.

## Key commands

```bash
# TypeScript check (fast, no build)
npx tsc --noEmit

# Metro dev server
npm start

# Run on device/emulator
npm run android
npm run ios

# Android debug APK build
cd android && ANDROID_HOME=$HOME/Library/Android/sdk ./gradlew assembleDebug

# iOS CocoaPods (required after any native dep change)
cd ios && pod install

# iOS simulator build
cd ios && xcodebuild -workspace TestingGround.xcworkspace -scheme TestingGround \
  -configuration Debug -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build

# iOS simulator build (output to ios/dist/)
cd ios && xcodebuild -workspace TestingGround.xcworkspace -scheme TestingGround \
  -configuration Debug -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -derivedDataPath ./dist build
```

## npm cache quirk

System npm cache has root-owned files. Always use the custom cache:

```bash
npm config set cache $HOME/workspace/.npm-cache
```

## Architecture

```
App.tsx → src/navigation/AppNavigator.tsx (NativeStack v7)
  ├── LoginScreen    (initialRoute)  — admin/123456 hardcoded
  ├── HomeScreen                     — replace() to Login on logout
  ├── TodoListScreen
  ├── FormScreen
  └── CalculatorScreen
```

- `src/screens/*.tsx` — all UI pages
- `src/navigation/AppNavigator.tsx` — stack config
- Entry point: `index.js` → `App.tsx`

## Appium / accessibility contract

**Every interactive element must have both `accessibilityLabel` and `testID` set to the same value.** Appium uses `accessibility id` strategy which works cross-platform through these props.

When adding or modifying UI elements, follow the naming convention in README.md Appium element tables (e.g. `calcDigit_0`, `todoText_{i}`).

## Environment

- Node.js >= 22.11 (enforced in package.json engines)
- JDK 17 (`/usr/local/opt/openjdk@17`)
- ANDROID_HOME = `$HOME/Library/Android/sdk`
- iOS: Xcode 16+ with Simulator runtime 26.x
- CocoaPods installed via Ruby gems

## Code style

- Prettier: single quotes, trailing commas, arrowParens avoid
- ESLint: `@react-native` config
- No explicit return types on React components (inferred)