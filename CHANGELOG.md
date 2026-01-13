# Changelog

All notable changes to Mithril UI will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.2] - 2026-01-13

### Added
- Documentation for required Tailwind CSS source configuration in README

### Fixed
- Carousel component HEEx template formatting
- MCP server version lookup for CI compatibility
- Test module loading for function export checks

## [0.1.1] - 2026-01-09

### Fixed
- Minor bug fixes and improvements

## [0.1.0] - 2025-01-06

### Added

#### Core Infrastructure
- `MithrilUI` main module with component imports
- `MithrilUI.Components` macro for easy component usage
- `MithrilUI.Theme` module for theme configuration
- `MithrilUI.Theme.Generator` for custom theme CSS generation
- `MithrilUI.Animations` module with LiveView.JS animation presets
- `MithrilUI.Helpers` module with utility functions

#### Action Components
- `button` - Buttons with 10 variants, 4 sizes, and loading/disabled states
- `button_group` - Horizontal and vertical button groups
- `dropdown` - Dropdown menus with positioning options

#### Form Components
- `input` - Text inputs with validation, icons, and addons
- `textarea` - Multi-line text inputs
- `select` - Dropdown selection fields
- `checkbox` - Checkbox inputs with indeterminate state
- `radio` - Radio button groups
- `toggle` - Toggle switches
- `range` - Range slider inputs
- `file_input` - File upload inputs

#### Feedback Components
- `alert` - Alert messages with 4 variants and dismissible option
- `toast` - Toast notifications with positioning
- `modal` - Modal dialogs with sizes and responsive option
- `drawer` - Slide-out panels from all sides
- `progress` - Progress bars with indeterminate option
- `spinner` - Loading spinners
- `skeleton` - Content placeholder skeletons

#### Data Display Components
- `card` - Content cards with header, body, footer slots
- `table` - Data tables with sorting, zebra stripes, pinning
- `avatar` - User avatars with groups and indicators
- `badge` - Status badges with all color variants
- `accordion` - Collapsible content sections
- `list_group` - Vertical item lists
- `timeline` - Event timelines

#### Navigation Components
- `navbar` - Responsive top navigation
- `sidebar` - Side navigation with collapsible sections
- `breadcrumb` - Breadcrumb navigation trails
- `tabs` - Tab navigation with variants
- `pagination` - Page navigation controls
- `bottom_navigation` - Mobile bottom navigation

#### Overlay Components
- `tooltip` - Hover tooltips with positioning
- `popover` - Rich content popovers

#### Typography Components
- `heading` - Semantic headings h1-h6
- `text` - Styled paragraph and inline text
- `link` - Anchor links with variants
- `blockquote` - Styled quotations with citations
- `code` - Inline and block code display
- `kbd` - Keyboard key display

#### Extended Components
- `rating` - Star ratings with multiple shapes
- `stepper` - Step progress indicators
- `indicator` - Status indicators and dots
- `chat_bubble` - Chat message bubbles
- `footer` - Page footers with navigation
- `banner` - Announcement banners
- `carousel` - Image carousels with navigation
- `gallery` - Image gallery grids

#### Utility Components
- `theme_switcher` - Theme selection dropdowns and toggles
- `clipboard` - Copy to clipboard functionality
- `speed_dial` - Floating action button menus

#### Mix Tasks
- `mix mithril_ui.install` - Project installation task
- `mix mithril_ui.gen.themes` - Theme CSS generation task

#### AI Documentation
- `MithrilUI.AI.ComponentRegistry` - Component metadata registry
- `MithrilUI.AI.ComponentSelector` - AI-friendly component selection API
- JSON schema export for all components

#### Storybook
- Phoenix Storybook integration
- Stories for all 50+ components
- Interactive component playground

### Infrastructure
- 1060 unit tests with 100% component coverage
- DaisyUI 4.x theming support
- 35 built-in DaisyUI themes
- Custom theme generation
- Phoenix LiveView 1.0 compatibility
- Accessible components with WAI-ARIA support
