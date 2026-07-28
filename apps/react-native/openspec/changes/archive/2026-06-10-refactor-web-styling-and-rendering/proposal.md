## Why

Web 版本的样式体系存在结构性分裂：`index.css` 维护了一套共享类名（`.btn`、`.input`、`.navbar` 等），但 LoginScreen（175 行）和 HomeScreen（71 行）几乎 100% 使用 inline style，完全绕过这套 CSS。这导致颜色、间距、字体等设计值散落在 5 个文件里，改主题需逐文件查找替换，且无法利用 CSS 的响应式、hover 伪类等能力。

## What Changes

- **BREAKING**: Web `LoginScreen` 全部 inline style 迁移到 `index.css` 类名，移除 JSX 内嵌 `<style>` 标签和 keyframes
- **BREAKING**: Web `HomeScreen` 卡片 inline style 迁移到 `index.css`，用 CSS `:hover` 替代 JS 直接 DOM 操作
- Web `TodoListScreen` 列表项添加 `React.memo`，避免每次输入触发全量重渲染
- RN `CalculatorScreen` `handleDigit`/`handleOperator` 改用函数式 `setDisplay(prev => ...)`，移除 `display` 依赖使回调更稳定

## Capabilities

### New Capabilities
- `web-styling-system`: 统一 Web 端样式为 CSS 类名体系，消除 inline style 分裂
- `render-optimization`: Web TodoList memo 化列表项 + RN Calculator 回调依赖优化

### Modified Capabilities
- （无现有 spec 需要变更——当前变更均为实现层，不涉及用户可见行为变化）

## Impact

- `web/src/screens/LoginScreen.tsx`: 样式全面迁移，移除内嵌 `<style>`
- `web/src/screens/HomeScreen.tsx`: 样式迁移，hover 改为 CSS
- `web/src/index.css`: 新增 `.login-*`、`.home-*` 等类名
- `web/src/screens/TodoListScreen.tsx`: 列表项 memo 化
- `src/screens/CalculatorScreen.tsx`: 回调改用函数式 state 更新
- 无 API、依赖、后端系统变更
