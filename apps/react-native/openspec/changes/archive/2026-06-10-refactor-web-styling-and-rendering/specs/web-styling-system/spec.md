## ADDED Requirements

### Requirement: Web screens use CSS classes instead of inline styles
The web UI SHALL define all visual styles (colors, spacing, typography, hover effects, animations) in `web/src/index.css` as CSS classes. Individual screen components SHALL apply styles via `className` rather than `style={{...}}` props.

#### Scenario: Login screen styling
- **WHEN** the login page renders
- **THEN** all visual properties (background, padding, border-radius, gradient, hover effects) SHALL be defined in `index.css` and applied via `className`

#### Scenario: Home screen card hover
- **WHEN** the user hovers over a navigation card on the home screen
- **THEN** the hover effect (box-shadow, translateY) SHALL be triggered by CSS `:hover` pseudo-class, not by `onMouseEnter`/`onMouseLeave` JS handlers

#### Scenario: No inline `<style>` tags in JSX
- **WHEN** any web screen component renders
- **THEN** no JSX `<style>` tag SHALL appear in the component output; all `@keyframes` SHALL live in `index.css`

### Requirement: CSS animations via stylesheet
All CSS animations (`@keyframes float`, `@keyframes fadeInUp`, `@keyframes shine`) SHALL be defined in `web/src/index.css` and applied via class names.

#### Scenario: Login page floating icons animation
- **WHEN** the login page loads
- **THEN** floating icon animation SHALL be defined in `index.css` and triggered via a CSS class

#### Scenario: Login page shine animation
- **WHEN** the login button is rendered
- **THEN** the gradient shine animation SHALL be defined in `index.css` as `@keyframes shine` and applied via a CSS class

### Requirement: No direct DOM style manipulation via JS
Web screen components SHALL NOT set element styles directly via event handlers (e.g., `e.currentTarget.style.boxShadow = ...`). All state-driven style changes SHALL use CSS classes toggled by React state.

#### Scenario: Card hover state
- **WHEN** the user hovers over a home screen card
- **THEN** the hover visual change SHALL be driven by CSS `:hover`, not by `onMouseEnter` setting `style` properties
