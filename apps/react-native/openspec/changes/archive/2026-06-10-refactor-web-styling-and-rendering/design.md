## Context

项目同时维护 React Native（`src/screens/*.tsx`）和纯 React Web（`web/src/screens/*.tsx`）两套界面，Appium/Selenium 通过 `accessibilityLabel` / `testID`（RN）和 `aria-label` / `id`（Web）定位元素。Web 端已有 `web/src/index.css`（74 行共享样式），但 LoginScreen（175 行）和 HomeScreen（71 行）完全使用 inline style，形成两套并行样式体系。

RN 端 CalculatorScreen 中 `handleDigit` / `handleOperator` 直接读取 `display` state 而非使用函数式更新，导致 `useCallback` 依赖 `display`，每次按键都重建回调。Web 端 TodoListScreen 列表项无 memo，每次输入都全量重渲染。

## Goals / Non-Goals

**Goals:**
- 统一 Web 端样式到 `index.css`，消除 inline style 分裂
- 移除 JSX 内嵌 `<style>` 标签，keyframes 移到 CSS 文件
- 用 CSS `:hover` 替代 JS 直接 DOM 操作
- Web TodoList 列表项 memo 化，减少输入时的重渲染
- RN Calculator 回调稳定化，减少不必要的重建

**Non-Goals:**
- 不改动 RN 端样式体系（RN 用 StyleSheet，不在此 scope）
- 不引入 CSS-in-JS 或新样式框架
- 不改动 Appium/Selenium 元素 ID（用户可见行为不变）
- 不改动路由、导航逻辑

## Decisions

### D1: 统一使用 CSS 类名，彻底移除 inline style
**选择**: 将所有 Web 屏幕的 inline style 迁移到 `index.css` 的类名。
** rationale**: `index.css` 已存在且各屏幕已有 `className` 复用基础（`.btn`、`.input`、`.navbar` 等），继续沿用比引入新方案（CSS modules、Tailwind 等）成本最低，且与项目"轻量 web 版本"定位一致。
**替代方案**: CSS Modules——增加构建复杂度，项目已用 Vite 零配置，无需额外开销；Tailwind——过度工程化。

### D2: 动画 keyframes 放 index.css，通过类名应用
**选择**: LoginScreen 的 `@keyframes float`、`@keyframes fadeInUp`、`@keyframes shine` 移到 `index.css`，组件内用 `className` 引用。
**rationale**: JSX 内嵌 `<style>` 影响 SSR 兼容性、难以预览、IDE 无法 lint，与分离关注点原则相悖。
**替代方案**: 保持内嵌 style——不可维护，拒绝。

### D3: hover 效果用 CSS `:hover` 伪类
**选择**: HomeScreen 卡片的 `onMouseEnter`/`onMouseLeave` 直接 DOM 操作移除，改用 CSS `:hover`。
**rationale**: CSS 天生适合处理交互状态，React 不需要感知 hover，减少 JS 执行和重渲染触发。
**替代方案**: CSS-in-JS（如 emotion）——不需要，纯 CSS 够用。

### D4: TodoList 列表项用 React.memo
**选择**: 将 `todos.map` 中的列表项抽取为 `TodoItem` 组件并用 `React.memo` 包裹。
**rationale**: 输入框 `setInput` 触发父组件重渲染时，只有输入相关的部分需要更新，已完成/未变化的 todo 项应跳过。Web 端无 FlashList 等虚拟列表，memo 是最直接优化。
**替代方案**: 虚拟列表——数据量小（测试目标 App），过度优化。

### D5: RN Calculator 使用函数式 state 更新
**选择**: `handleDigit` 和 `handleOperator` 内 `setDisplay(display + digit)` → `setDisplay(prev => prev + digit)`，移除 `display` 从 deps 数组。
**rationale**: 函数式更新保证基于最新 state，无需将 `display` 放入依赖。Web 端已采用此写法（CalcScreen.tsx:41），RN 端对齐。`useCallback` 依赖越少越稳定。
**替代方案**: 使用 `useRef` 保存 display——增加复杂度，函数式更新是 React 推荐方式。

## Risks / Trade-offs

- **[CSS 类名爆炸]** → 限制：复用现有命名约定（BEM-like），只添加必要的 `.login-*`、`.home-*` 前缀，避免全局污染
- **[memo 过度使用]** → TodoList 数据量小，memo 的浅比较开销可能超过收益，但作为测试 App 的成分优化仍有教育价值
- **[动画从 inline 迁移到 CSS 的兼容性]** → 无风险，CSS animations 广泛支持，且当前仅用 transform/opacity
- **[RN Calculator 函数式更新行为差异]** → 函数式更新与直接读取 state 在逻辑上等价，测试通过后无风险
