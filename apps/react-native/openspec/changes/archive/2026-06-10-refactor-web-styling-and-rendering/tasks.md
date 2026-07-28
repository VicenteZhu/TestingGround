## 1. CSS Foundation

- [x] 1.1 在 `web/src/index.css` 添加 `@keyframes float`、`@keyframes fadeInUp`、`@keyframes shine`
- [x] 1.2 在 `web/src/index.css` 添加 `.login-*` 类名（logo box、input wrapper、button、floating icon、hint text）
- [x] 1.3 在 `web/src/index.css` 添加 `.home-card`、`.home-card:hover` 等卡片样式类
- [x] 1.4 确认现有 `.navbar`、`.btn`、`.input` 等共享类名覆盖 HomeScreen 所需样式

## 2. Migrate LoginScreen

- [x] 2.1 将 `web/src/screens/LoginScreen.tsx` 中所有 inline style 替换为 `className`
- [x] 2.2 移除 JSX 内嵌 `<style>` 标签，引用 `index.css` 中的 keyframes 类
- [x] 2.3 将 `FloatingIcon` 组件定义移到组件外部
- [x] 2.4 验证元素 ID 不变：`usernameInput`、`passwordInput`、`loginButton`、`loginError`

## 3. Migrate HomeScreen

- [x] 3.1 将 `web/src/screens/HomeScreen.tsx` 中所有 inline style 替换为 `className`
- [x] 3.2 移除 `onMouseEnter`/`onMouseLeave` JS hover 处理，改用 CSS `:hover`
- [x] 3.3 验证元素 ID 不变：`navTodoList`、`navForm`、`navCalculator`、`logoutButton`

## 4. Web TodoList Memo Optimization

- [x] 4.1 将 `web/src/screens/TodoListScreen.tsx` 列表项抽取为 `TodoItem` 并用 `React.memo` 包裹
- [x] 4.2 验证元素 ID 不变：`todoInput`、`addTodoButton`、`todoList`、`todoCheckbox_{i}`、`todoText_{i}`、`todoDelete_{i}`

## 5. RN Calculator Functional Updates

- [x] 5.1 更新 `src/screens/CalculatorScreen.tsx` 中 `handleDigit`：改用 `setDisplay(prev => prev === '0' ? digit : prev + digit)`，移除 `display` 依赖
- [x] 5.2 更新 `handleOperator` 中 `setDisplay` 调用为函数式更新，移除 `display` 依赖
- [x] 5.3 运行 `npx tsc --noEmit` 确认无类型错误
