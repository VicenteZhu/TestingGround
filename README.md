# TestingGround

用于 **Appium 自动化测试**的 React Native 跨平台（Android / iOS）被测应用，提供登录、Todo 列表、表单、计算器等典型 UI 场景。

---

## 环境要求

### 所有平台

| 工具 | 版本要求 | 安装方式 |
|------|---------|---------|
| Node.js | >= 22.11 | [nvm](https://github.com/nvm-sh/nvm) 或 [官网](https://nodejs.org) |
| npm | >= 10 | 随 Node.js 附带 |
| Watchman | latest | `brew install watchman` |
| Ruby | >= 3.0 | `brew install ruby` |
| Bundler | latest | `gem install bundler` |

### Android

| 工具 | 版本要求 | 安装方式 |
|------|---------|---------|
| JDK | 17 | `brew install openjdk@17` |
| Android Studio | latest | [官网下载](https://developer.android.com/studio) |
| Android SDK Platform | 34+ | Android Studio SDK Manager |
| Android SDK Build-Tools | 34.0.0 | Android Studio SDK Manager |
| Android Emulator (x86_64) | API 34+ | Android Studio AVD Manager |

### iOS（仅 macOS）

| 工具 | 版本要求 | 安装方式 |
|------|---------|---------|
| Xcode | 16+ | Mac App Store |
| CocoaPods | latest | `sudo gem install cocoapods` |

---

## 环境安装步骤

### 1. 安装 nvm 和 Node.js

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.zshrc
nvm install 22
nvm use 22
```

### 2. 安装 JDK 17

```bash
brew install openjdk@17
echo 'export JAVA_HOME="/usr/local/opt/openjdk@17"' >> ~/.zshrc
source ~/.zshrc
```

### 3. 安装 Watchman

```bash
brew install watchman
```

### 4. 安装 Ruby（macOS 系统自带版本过低）

```bash
brew install ruby
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 5. 安装 Android Studio

从 [developer.android.com/studio](https://developer.android.com/studio) 下载安装。

首次启动后，通过 SDK Manager 安装：
- **SDK Platforms**: Android 15.0 (API 35) 或更高
- **SDK Tools**: Android SDK Build-Tools、Android Emulator、Android SDK Platform-Tools
- **System Image**: Intel x86_64 System Image (API 35)

配置环境变量：

```bash
echo 'export ANDROID_HOME="$HOME/Library/Android/sdk"' >> ~/.zshrc
echo 'export ANDROID_SDK_ROOT="$ANDROID_HOME"' >> ~/.zshrc
echo 'export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

创建 Android 模拟器（可选）：

```bash
sdkmanager "system-images;android-35;google_apis;x86_64"
avdmanager create avd -n Pixel_10_Pro_XL -k "system-images;android-35;google_apis;x86_64" -d "pixel_10_pro_xl"
```

### 6. 安装 Xcode（iOS，仅 macOS）

从 Mac App Store 搜索安装 Xcode。安装后启动一次以同意协议，然后切换命令行工具路径：

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

### 7. 安装 CocoaPods（iOS，仅 macOS）

```bash
sudo gem install cocoapods
```

如果 `pod` 命令提示找不到，将 Ruby gems bin 目录加入 PATH：

```bash
echo 'export PATH="/usr/local/lib/ruby/gems/$(ruby -e "puts Gem.ruby_version")/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 8. 验证环境

```bash
node --version     # v22.x
java -version      # openjdk 17.x
adb --version      # Android Debug Bridge
xcrun simctl list devices available  # iOS 模拟器列表
watchman --version #
pod --version      # CocoaPods
emulator -list-avds # Android 模拟器
```

---

## 快速开始

```bash
# 进入项目目录
cd TestingGround

# 安装依赖
npm install

# 安装 iOS CocoaPods
cd ios && pod install && cd ..

# 启动 Metro
npm start

# 新终端运行 Android
npm run android

# 新终端运行 iOS
npm run ios
```

首次 Android 构建约 5-10 分钟，后续增量构建约 1 分钟。

---

## 项目结构

```
TestingGround/
├── src/
│   ├── screens/
│   │   ├── LoginScreen.tsx        # 登录页 (admin / 123456)
│   │   ├── HomeScreen.tsx         # 导航仪表盘
│   │   ├── TodoListScreen.tsx     # Todo 增删勾选
│   │   ├── FormScreen.tsx         # 注册表单 (6 种控件)
│   │   └── CalculatorScreen.tsx   # 四则运算计算器
│   └── navigation/
│       └── AppNavigator.tsx       # 5 页面导航栈
├── android/                       # Android 原生工程
├── ios/                           # iOS 原生工程 (CocoaPods)
├── App.tsx                        # 入口
└── package.json
```

---

## 页面与功能

| 页面 | 功能 | 交互元素数 |
|------|------|-----------|
| LoginScreen | 账号密码登录校验 | 4 |
| HomeScreen | 各功能页入口 + 退出登录 | 4 |
| TodoListScreen | 列表增删、勾选完成 | 动态 (每项 4) |
| FormScreen | TextInput / Radio / Switch / Chip 选择 / 提交回显 | 12+ |
| CalculatorScreen | 数字输入、四则运算、等号、清除 | 17 |

内建账号: `admin` / `123456`

---

## Appium 元素定位参考

所有可交互元素统一设置 `accessibilityLabel` + `testID`，Appium 使用 **Accessibility ID** 策略，Android / iOS 通用。

### 登录页 (LoginScreen)

| 元素 | accessibility id |
|------|-----------------|
| 用户名输入框 | `usernameInput` |
| 密码输入框 | `passwordInput` |
| 登录按钮 | `loginButton` |
| 错误提示 | `loginError` |

### 首页 (HomeScreen)

| 元素 | accessibility id |
|------|-----------------|
| 进入 Todo 列表 | `navTodoList` |
| 进入表单 | `navForm` |
| 进入计算器 | `navCalculator` |
| 退出登录 | `logoutButton` |

### Todo 列表页 (TodoListScreen)

| 元素 | accessibility id |
|------|-----------------|
| 输入框 | `todoInput` |
| 添加按钮 | `addTodoButton` |
| 列表容器 | `todoList` |
| 第 i 项文本 | `todoText_{i}` |
| 第 i 项勾选框 | `todoCheckbox_{i}` |
| 第 i 项删除 | `todoDelete_{i}` |

> i 从 0 开始

### 表单页 (FormScreen)

| 元素 | accessibility id |
|------|-----------------|
| 姓名输入 | `nameInput` |
| 邮箱输入 | `emailInput` |
| 性别 - 男 | `genderRadioMale` |
| 性别 - 女 | `genderRadioFemale` |
| 订阅开关 | `subscribeSwitch` |
| 国家选择 (China) | `country_China` |
| 国家选择 (United States) | `country_UnitedStates` |
| 国家选择 (Japan) | `country_Japan` |
| 国家选择 (Germany) | `country_Germany` |
| 国家选择 (Other) | `country_Other` |
| 提交按钮 | `submitButton` |
| 回显结果区域 | `formResult` |

### 计算器页 (CalculatorScreen)

| 元素 | accessibility id |
|------|-----------------|
| 显示屏 | `calcDisplay` |
| 数字 0-9 | `calcDigit_0` ~ `calcDigit_9` |
| 加 | `calcAdd` |
| 减 | `calcSubtract` |
| 乘 | `calcMultiply` |
| 除 | `calcDivide` |
| 等号 | `calcEquals` |
| 清除 | `calcClear` |

### Appium 示例

```python
from appium.webdriver.common.appiumby import AppiumBy

# Android
driver.find_element(AppiumBy.ACCESSIBILITY_ID, "usernameInput").send_keys("admin")
driver.find_element(AppiumBy.ACCESSIBILITY_ID, "passwordInput").send_keys("123456")
driver.find_element(AppiumBy.ACCESSIBILITY_ID, "loginButton").click()

# iOS — 相同策略
driver.find_element(AppiumBy.ACCESSIBILITY_ID, "usernameInput").send_keys("admin")
```