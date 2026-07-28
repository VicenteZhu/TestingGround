# TestingGround

A **monorepo** containing cross-platform UI automation testing target applications. Built for Appium, Selenium, and XCTest-based UI testing across iOS, Android, and Web.

[中文文档](README_CN.md) | [Build Guide](BUILD.md)

---

## Repository Structure

```
TestingGround/
├── apps/
│   ├── react-native/       # React Native cross-platform app (iOS + Android + Web)
│   └── ios-native/         # Native iOS app (UIKit + SwiftUI)
├── scripts/                # Shared build & CI scripts
└── AGENTS.md               # AI agent development guide
```

## Sub-Projects

| Project | Tech Stack | Platforms | Purpose |
|---------|-----------|-----------|---------|
| [react-native](apps/react-native/) | React Native 0.85.3 + TypeScript | iOS / Android / Web | Appium / Selenium automation target |
| [ios-native](apps/ios-native/) | Swift 5 / UIKit + SwiftUI | iOS | XCTest / Appium native target |

Both apps share the same testing credentials: **`admin` / `123456`**

---

## Quick Start

### React Native App

```bash
cd apps/react-native
npm install
npm start            # Start Metro dev server
npm run ios          # Run on iOS simulator
npm run android      # Run on Android emulator
npm run web          # Run web dev server
```

### iOS Native App

```bash
cd apps/ios-native
xcodegen generate    # Generate Xcode project (if needed)
# Open TestingGround.xcodeproj in Xcode, or:
xcodebuild -project TestingGround.xcodeproj -scheme TestingGround \
  -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
```

See [BUILD.md](BUILD.md) for detailed environment setup and build instructions.

---

## Screens & Features

### React Native App

| Screen | Features | Interactive Elements |
|--------|----------|---------------------|
| LoginScreen | Username/password validation | 4 |
| HomeScreen | Feature navigation + logout | 4 |
| TodoListScreen | List CRUD, checkbox toggle | Dynamic (4 per item) |
| FormScreen | TextInput / Radio / Switch / Chip / Submit | 12+ |
| CalculatorScreen | Digit input, 4 operations, equals, clear | 17 |

### iOS Native App

| Screen | Features | Test ID Prefix |
|--------|----------|----------------|
| LoginViewController | Login form, remember me, activity indicator | `login_*` |
| FormTestViewController | Multi-control form, date picker, slider, switch | `form_*` |
| ListTestViewController | UITableView, search bar, add/delete | `list_*` |
| AlertTestViewController | Simple / confirm / input / action sheet / custom alerts | `alert_*` |
| SettingsViewController | Theme toggle, cache clear, about info | `settings_*` |

---

## Test ID Conventions

### React Native (Appium / Selenium)

Every interactive element has both `accessibilityLabel` and `testID` set to the **same value**. Appium locates elements via the **Accessibility ID** strategy.

| Element | Accessibility ID |
|---------|-----------------|
| Username input | `usernameInput` |
| Password input | `passwordInput` |
| Login button | `loginButton` |
| Todo input | `todoInput` |
| Todo item text (index i) | `todoText_{i}` |
| Calculator digits | `calcDigit_0` ~ `calcDigit_9` |
| Calculator operations | `calcAdd`, `calcSubtract`, `calcMultiply`, `calcDivide` |

### iOS Native (XCTest / Appium)

All UI elements use `accessibilityIdentifier` with the pattern: `<page>_<element_type>_<name>`

| Element | Identifier |
|---------|-----------|
| Username field | `login_username_textfield` |
| Password field | `login_password_textfield` |
| Login button | `login_submit_button` |
| Form submit | `form_submit_button` |
| List table view | `list_table_view` |

---

## Prerequisites

| Tool | Version | Notes |
|------|---------|-------|
| Node.js | >= 22.11 | Via [nvm](https://github.com/nvm-sh/nvm) recommended |
| JDK | 17 | `brew install openjdk@17` |
| Xcode | 16+ | Mac App Store |
| CocoaPods | latest | `sudo gem install cocoapods` |
| XcodeGen | latest | For iOS native project: `brew install xcodegen` |
| Android Studio | latest | With SDK 34+ |

See [BUILD.md](BUILD.md) for step-by-step environment setup.

---

## npm cache note

If your system npm cache has root-owned files, configure a custom cache:

```bash
npm config set cache $HOME/workspace/.npm-cache
```

---

## License

MIT License
