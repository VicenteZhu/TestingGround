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