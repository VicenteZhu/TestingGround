# TestingGround

跨平台 UI 自动化测试被测应用 **Monorepo**。支持 Appium、Selenium 和 XCTest 框架，覆盖 iOS、Android 和 Web 平台。

[English](README.md) | [构建教程](BUILD.md)

---

## 仓库结构

```
TestingGround/
├── apps/
│   ├── react-native/       # React Native 跨平台应用 (iOS + Android + Web)
│   └── ios-native/         # iOS 原生应用 (UIKit + SwiftUI)
├── scripts/                # 共享构建/CI 脚本
└── AGENTS.md               # AI Agent 开发指南
```

## 子项目说明

| 子项目 | 技术栈 | 平台 | 用途 |
|--------|--------|------|------|
| [react-native](apps/react-native/) | React Native 0.85.3 + TypeScript | iOS / Android / Web | Appium / Selenium 自动化测试目标 |
| [ios-native](apps/ios-native/) | Swift 5 / UIKit + SwiftUI | iOS | XCTest / Appium 原生测试目标 |

两个应用共用测试账号：**`admin` / `123456`**

---

## 快速开始

### React Native 应用

```bash
cd apps/react-native
npm install
npm start            # 启动 Metro 开发服务器
npm run ios          # 在 iOS 模拟器上运行
npm run android      # 在 Android 模拟器上运行
npm run web          # 启动 Web 开发服务器
```

### iOS 原生应用

```bash
cd apps/ios-native
xcodegen generate    # 生成 Xcode 项目（如需要）
# 用 Xcode 打开 TestingGround.xcodeproj，或命令行构建：
xcodebuild -project TestingGround.xcodeproj -scheme TestingGround \
  -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
```

详细的环境搭建和构建说明请参考 [构建教程](BUILD.md)。

---

## 页面与功能

### React Native 应用

| 页面 | 功能 | 交互元素数 |
|------|------|-----------|
| LoginScreen | 用户名/密码登录验证 | 4 |
| HomeScreen | 功能导航 + 登出 | 4 |
| TodoListScreen | 待办事项增删改查、复选框 | 动态（每项 4 个） |
| FormScreen | 文本输入 / 单选 / 开关 / Chip 选择 / 提交 | 12+ |
| CalculatorScreen | 数字输入、四则运算、等号、清除 | 17 |

### iOS 原生应用

| 页面 | 功能 | 测试 ID 前缀 |
|------|------|-------------|
| LoginViewController | 登录表单、记住我、活动指示器 | `login_*` |
| FormTestViewController | 多控件表单、日期选择器、滑块、开关 | `form_*` |
| ListTestViewController | UITableView、搜索栏、添加/删除 | `list_*` |
| AlertTestViewController | 简单/确认/输入/操作表/自定义弹窗 | `alert_*` |
| SettingsViewController | 主题切换、缓存清除、关于信息 | `settings_*` |

---

## 测试 ID 规范

### React Native（Appium / Selenium）

每个交互元素同时设置 `accessibilityLabel` 和 `testID` 为**相同的值**。Appium 通过 **Accessibility ID** 策略定位元素。

| 元素 | Accessibility ID |
|------|-----------------|
| 用户名输入框 | `usernameInput` |
| 密码输入框 | `passwordInput` |
| 登录按钮 | `loginButton` |
| 待办输入框 | `todoInput` |
| 待办项文本（索引 i） | `todoText_{i}` |
| 计算器数字键 | `calcDigit_0` ~ `calcDigit_9` |
| 计算器运算符 | `calcAdd`、`calcSubtract`、`calcMultiply`、`calcDivide` |

### iOS 原生（XCTest / Appium）

所有 UI 元素使用 `accessibilityIdentifier`，命名格式：`<页面>_<元素类型>_<名称>`

| 元素 | 标识符 |
|------|--------|
| 用户名输入框 | `login_username_textfield` |
| 密码输入框 | `login_password_textfield` |
| 登录按钮 | `login_submit_button` |
| 表单提交按钮 | `form_submit_button` |
| 列表表格视图 | `list_table_view` |

---

## 环境要求

| 工具 | 版本 | 安装方式 |
|------|------|---------|
| Node.js | >= 22.11 | 推荐通过 [nvm](https://github.com/nvm-sh/nvm) |
| JDK | 17 | `brew install openjdk@17` |
| Xcode | 16+ | Mac App Store |
| CocoaPods | 最新 | `sudo gem install cocoapods` |
| XcodeGen | 最新 | `brew install xcodegen`（iOS 原生项目需要） |
| Android Studio | 最新 | 含 SDK 34+ |

详细安装步骤请参考 [构建教程](BUILD.md)。

---

## npm 缓存说明

如果系统 npm 缓存存在 root 权限文件，需要配置自定义缓存目录：

```bash
npm config set cache $HOME/workspace/.npm-cache
```

---

## 许可

MIT License
