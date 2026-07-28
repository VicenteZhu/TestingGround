# TestingGround

A cross-platform (Android / iOS / Web) app built as an **Appium / Selenium automation testing target**, providing typical UI scenarios: login, todo list, form, and calculator. Mobile app built with React Native; web app built with Vite + React.

---

## Prerequisites

### All Platforms

| Tool | Version | Install |
|------|---------|---------|
| Node.js | >= 22.11 | [nvm](https://github.com/nvm-sh/nvm) or [official site](https://nodejs.org) |
| npm | >= 10 | Bundled with Node.js |
| Watchman | latest | `brew install watchman` |
| Ruby | >= 3.0 | `brew install ruby` |
| Bundler | latest | `gem install bundler` |

### Android

| Tool | Version | Install |
|------|---------|---------|
| JDK | 17 | `brew install openjdk@17` |
| Android Studio | latest | [Download](https://developer.android.com/studio) |
| Android SDK Platform | 34+ | Android Studio SDK Manager |
| Android SDK Build-Tools | 34.0.0 | Android Studio SDK Manager |
| Android Emulator (x86_64) | API 34+ | Android Studio AVD Manager |

### iOS (macOS only)

| Tool | Version | Install |
|------|---------|---------|
| Xcode | 16+ | Mac App Store |
| CocoaPods | latest | `sudo gem install cocoapods` |

---

## Setup

### 1. Install nvm and Node.js

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.zshrc
nvm install 22
nvm use 22
```

### 2. Install JDK 17

```bash
brew install openjdk@17
echo 'export JAVA_HOME="/usr/local/opt/openjdk@17"' >> ~/.zshrc
source ~/.zshrc
```

### 3. Install Watchman

```bash
brew install watchman
```

### 4. Install Ruby (macOS system Ruby may be too old)

```bash
brew install ruby
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 5. Install Android Studio

Download from [developer.android.com/studio](https://developer.android.com/studio).

After the first launch, install via SDK Manager:
- **SDK Platforms**: Android 15.0 (API 35) or higher
- **SDK Tools**: Android SDK Build-Tools, Android Emulator, Android SDK Platform-Tools
- **System Image**: Intel x86_64 System Image (API 35)

Configure environment variables:

```bash
echo 'export ANDROID_HOME="$HOME/Library/Android/sdk"' >> ~/.zshrc
echo 'export ANDROID_SDK_ROOT="$ANDROID_HOME"' >> ~/.zshrc
echo 'export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Create an Android emulator (optional):

```bash
sdkmanager "system-images;android-35;google_apis;x86_64"
avdmanager create avd -n Pixel_10_Pro_XL -k "system-images;android-35;google_apis;x86_64" -d "pixel_10_pro_xl"
```

### 6. Install Xcode (iOS, macOS only)

Install from Mac App Store. Launch once to accept the license, then switch the command-line tools path:

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

### 7. Install CocoaPods (iOS, macOS only)

```bash
sudo gem install cocoapods
```

If the `pod` command is not found, add the Ruby gems bin directory to PATH:

```bash
echo 'export PATH="/usr/local/lib/ruby/gems/$(ruby -e "puts Gem.ruby_version")/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 8. Verify

```bash
node --version     # v22.x
java -version      # openjdk 17.x
adb --version      # Android Debug Bridge
xcrun simctl list devices available  # iOS simulator list
watchman --version #
pod --version      # CocoaPods
emulator -list-avds # Android emulator
```

---

## Quick Start

### Mobile (React Native)

```bash
cd TestingGround
npm install
cd ios && pod install && cd ..

# Start Metro
npm start

# In a new terminal
npm run android   # Android
npm run ios       # iOS
```

The first Android build takes about 5-10 minutes; subsequent incremental builds take about 1 minute.

### Web (React + Vite)

```bash
cd TestingGround/web
npm install

# Dev server (localhost:3000)
npm run dev

# Production build (outputs to web/dist/)
npm run build
```

Or from the project root:

```bash
npm run web         # dev server
npm run web-build   # production build
```

---

## Project Structure

```
TestingGround/
├── src/
│   ├── screens/
│   │   ├── LoginScreen.tsx        # Login (admin / 123456)
│   │   ├── HomeScreen.tsx         # Navigation dashboard
│   │   ├── TodoListScreen.tsx     # Todo list: add, delete, toggle
│   │   ├── FormScreen.tsx         # Registration form (6 control types)
│   │   └── CalculatorScreen.tsx   # Basic arithmetic calculator
│   └── navigation/
│       └── AppNavigator.tsx       # 5-screen navigation stack
├── android/                       # Android native project
├── ios/                           # iOS native project (CocoaPods)
├── web/                           # Web app (Vite + React)
│   ├── src/
│   │   ├── screens/
│   │   │   ├── LoginScreen.tsx
│   │   │   ├── HomeScreen.tsx
│   │   │   ├── TodoListScreen.tsx
│   │   │   ├── FormScreen.tsx
│   │   │   └── CalculatorScreen.tsx
│   │   ├── App.tsx                # React Router config
│   │   ├── main.tsx               # Web entry point
│   │   └── index.css              # Global styles
│   ├── index.html
│   ├── vite.config.ts
│   └── package.json
├── App.tsx                        # RN entry point
└── package.json
```

---

## Pages & Features

| Page | Features | Interactive Elements |
|------|----------|---------------------|
| LoginScreen | Username/password validation | 4 |
| HomeScreen | Feature navigation + logout | 4 |
| TodoListScreen | List CRUD, checkbox toggle | Dynamic (4 per item) |
| FormScreen | TextInput / Radio / Switch / Chip selection / Submit | 12+ |
| CalculatorScreen | Digit input, 4 operations, equals, clear | 17 |

Built-in credentials: `admin` / `123456`

---

## Selenium / Web Element Locators

The web version uses standard HTML `id` attributes matching the same element IDs as the mobile version. Selenium locates elements via `By.ID`.

All element IDs are identical across React Native (Appium) and Web (Selenium).

### Selenium Example (Python)

```python
from selenium import webdriver
from selenium.webdriver.common.by import By

driver = webdriver.Chrome()
driver.get("http://localhost:3000")

driver.find_element(By.ID, "usernameInput").send_keys("admin")
driver.find_element(By.ID, "passwordInput").send_keys("123456")
driver.find_element(By.ID, "loginButton").click()
```

---

## Appium Element Locators

All interactive elements use `accessibilityLabel` + `testID` with identical values. Appium uses the **Accessibility ID** strategy, which works on both Android and iOS.

### LoginScreen

| Element | Accessibility ID |
|---------|-----------------|
| Username input | `usernameInput` |
| Password input | `passwordInput` |
| Login button | `loginButton` |
| Error message | `loginError` |

### HomeScreen

| Element | Accessibility ID |
|---------|-----------------|
| Navigate to Todo | `navTodoList` |
| Navigate to Form | `navForm` |
| Navigate to Calculator | `navCalculator` |
| Logout | `logoutButton` |

### TodoListScreen

| Element | Accessibility ID |
|---------|-----------------|
| Input field | `todoInput` |
| Add button | `addTodoButton` |
| List container | `todoList` |
| Item text (index i) | `todoText_{i}` |
| Item checkbox (index i) | `todoCheckbox_{i}` |
| Item delete (index i) | `todoDelete_{i}` |

> Index `i` starts from 0

### FormScreen

| Element | Accessibility ID |
|---------|-----------------|
| Name input | `nameInput` |
| Email input | `emailInput` |
| Gender - Male | `genderRadioMale` |
| Gender - Female | `genderRadioFemale` |
| Subscribe switch | `subscribeSwitch` |
| Country - China | `country_China` |
| Country - United States | `country_UnitedStates` |
| Country - Japan | `country_Japan` |
| Country - Germany | `country_Germany` |
| Country - Other | `country_Other` |
| Submit button | `submitButton` |
| Result display | `formResult` |

### CalculatorScreen

| Element | Accessibility ID |
|---------|-----------------|
| Display | `calcDisplay` |
| Digits 0-9 | `calcDigit_0` ~ `calcDigit_9` |
| Add | `calcAdd` |
| Subtract | `calcSubtract` |
| Multiply | `calcMultiply` |
| Divide | `calcDivide` |
| Equals | `calcEquals` |
| Clear | `calcClear` |

### Appium Examples

```python
from appium.webdriver.common.appiumby import AppiumBy

# Android
driver.find_element(AppiumBy.ACCESSIBILITY_ID, "usernameInput").send_keys("admin")
driver.find_element(AppiumBy.ACCESSIBILITY_ID, "passwordInput").send_keys("123456")
driver.find_element(AppiumBy.ACCESSIBILITY_ID, "loginButton").click()

# iOS — same strategy
driver.find_element(AppiumBy.ACCESSIBILITY_ID, "usernameInput").send_keys("admin")
```