## ADDED Requirements

### Requirement: Web TodoList list items are memoized
The `web/src/screens/TodoListScreen.tsx` SHALL wrap its list item rendering in `React.memo` so that re-renders triggered by input changes do not rebuild unchanged list items.

#### Scenario: Adding a todo does not re-render existing items
- **WHEN** the user types in the todo input field
- **THEN** existing todo list items SHALL NOT re-render (only the input and its parent re-render)

#### Scenario: Toggling a todo re-renders only that item
- **WHEN** the user toggles a todo checkbox
- **THEN** only the toggled item SHALL re-render

### Requirement: RN Calculator handlers use functional state updates
The `src/screens/CalculatorScreen.tsx` SHALL use functional `setDisplay(prev => ...)` updates inside `handleDigit` and `handleOperator` to remove the `display` variable from `useCallback` dependency arrays.

#### Scenario: handleDigit callback stability
- **WHEN** the calculator is rendered
- **THEN** `handleDigit` SHALL NOT include `display` in its dependency array; the callback reference SHALL remain stable across digit presses

#### Scenario: handleOperator callback stability
- **WHEN** the calculator is rendered
- **THEN** `handleOperator` SHALL NOT include `display` in its dependency array
