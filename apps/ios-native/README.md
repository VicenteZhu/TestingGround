# TestingGround-iOS

一个用于 iOS UI 自动化测试的原生 iOS 应用。

## 功能特点

### 1. 登录页面测试
- 用户名/密码输入框
- 登录按钮
- 记住我开关
- 登录状态提示
- 活动指示器
- **测试ID**: `login_username_textfield`, `login_password_textfield`, `login_submit_button` 等

### 2. 表单页面测试
- 多种输入控件（文本框、日期选择器、滑块、开关等）
- 表单提交
- 结果展示
- **测试ID**: `form_name_textfield`, `form_email_textfield`, `form_submit_button` 等

### 3. 列表页面测试
- UITableView 展示
- 搜索栏
- 添加/删除功能
- 列表项点击
- **测试ID**: `list_table_view`, `list_search_bar`, `list_add_button` 等

### 4. 弹窗页面测试
- 简单弹窗
- 确认弹窗
- 输入弹窗
- 操作表
- 自定义弹窗
- **测试ID**: `alert_simple_button`, `alert_confirm_button` 等

### 5. 设置页面测试
- 主题切换
- 缓存清除
- 关于信息
- **测试ID**: `settings_table_view`, `settings_theme_switch` 等

## 项目结构

```
TestingGround-iOS/
├── TestingGround/
│   ├── TestingGround/
│   │   ├── AppDelegate.swift
│   │   ├── MainTabBarController.swift
│   │   ├── Views/
│   │   │   ├── LoginViewController.swift
│   │   │   ├── FormTestViewController.swift
│   │   │   ├── ListTestViewController.swift
│   │   │   ├── AlertTestViewController.swift
│   │   │   └── SettingsViewController.swift
│   │   └── Info.plist
│   └── TestingGroundUITests/
│       └── TestingGroundUITests.swift
└── README.md
```

## 使用说明

### 在 Xcode 中打开项目

由于这是一个演示项目，你需要：

1. 打开 Xcode
2. 选择 "Create a new Xcode project"
3. 选择 "iOS" -> "App"
4. 项目名称: `TestingGround`
5. 组织标识符: `com.testing.ground`
6. 界面: `Storyboard` 或 `SwiftUI` (本示例基于 UIKit)
7. 语言: `Swift`

### 添加文件到项目

将以下文件添加到你的 Xcode 项目中：

1. `AppDelegate.swift` - 应用入口
2. `MainTabBarController.swift` - 主标签栏控制器
3. `LoginViewController.swift` - 登录页面
4. `FormTestViewController.swift` - 表单测试页面
5. `ListTestViewController.swift` - 列表测试页面
6. `AlertTestViewController.swift` - 弹窗测试页面
7. `SettingsViewController.swift` - 设置页面

### 运行 UI 测试

1. 在 Xcode 中，选择 `TestingGroundUITests` scheme
2. 点击 `Product` -> `Test` 或按 `Cmd + U`
3. 查看测试结果

## 测试 ID 规范

所有 UI 元素都设置了 `accessibilityIdentifier`，命名规范为：

```
<页面>_<元素类型>_<元素名称>
```

例如：
- `login_username_textfield` - 登录页面的用户名文本框
- `form_submit_button` - 表单页面的提交按钮
- `list_table_view` - 列表页面的表格视图

## 注意事项

- 本项目为纯前端应用，无需后端服务器
- 登录功能使用硬编码 credentials: 用户名 `admin`, 密码 `123456`
- 所有数据存储在本地 (UserDefaults)
- 适合用于 UI 自动化测试学习和实践

## 技术栈

- Swift 5
- UIKit
- XCTest (UI 测试)
- iOS 14.0+

## 作者

Testing Team

## 许可

MIT License
