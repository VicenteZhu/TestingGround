# TestingGround

跨平台 UI 自动化测试被测应用 Monorepo。

## 项目结构

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
| [react-native](apps/react-native/) | React Native 0.85.3 + TypeScript | iOS / Android / Web | Appium 自动化测试目标 |
| [ios-native](apps/ios-native/) | Swift 5 / UIKit + SwiftUI | iOS | XCTest / Appium 原生测试目标 |

## 快速开始

### React Native 应用

```bash
cd apps/react-native
npm install
npm start          # Metro dev server
npm run ios        # 运行 iOS
npm run android    # 运行 Android
npm run web        # 运行 Web
```

### iOS 原生应用

```bash
cd apps/ios-native
xcodegen generate  # 生成 Xcode 项目（如需要）
# 用 Xcode 打开 TestingGround.xcodeproj
```

## 测试账号

两个应用均使用硬编码账号：`admin` / `123456`

## 测试 ID 规范

- **React Native**: `accessibilityLabel` + `testID` 同值，如 `calcDigit_0`、`todoText_{i}`
- **iOS Native**: `accessibilityIdentifier`，格式 `<页面>_<元素类型>_<名称>`，如 `login_username_textfield`

## 环境要求

- Node.js >= 22.11
- JDK 17
- Xcode 16+ / iOS Simulator 26.x
- CocoaPods
- XcodeGen（iOS 原生项目）

## 许可

MIT License
