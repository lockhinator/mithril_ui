# Mithril UI

[![Hex.pm](https://img.shields.io/hexpm/v/mithril_ui.svg)](https://hex.pm/packages/mithril_ui)
[![Docs](https://img.shields.io/badge/hex-docs-blue.svg)](https://hexdocs.pm/mithril_ui)
[![License](https://img.shields.io/hexpm/l/mithril_ui.svg)](https://github.com/lockhinator/mithril_ui/blob/master/LICENSE)

A comprehensive Phoenix LiveView component library built with DaisyUI theming and Flowbite-inspired designs.

## Features

- **50+ Components** - Actions, Forms, Feedback, Data Display, Navigation, Overlays, Typography, and more
- **DaisyUI Theming** - 35 built-in themes with custom theme support
- **Phoenix LiveView** - Built for LiveView with full HEEx template support
- **Accessible** - WAI-ARIA compliant components
- **AI-Ready** - Component metadata and schemas for AI-assisted development

## Installation

Add `mithril_ui` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mithril_ui, "~> 0.1.0"}
  ]
end
```

Then run the installer:

```bash
mix deps.get
mix mithril_ui.install
```

## Quick Start

### 1. Import Components

In your `my_app_web.ex`, add the components to your helpers:

```elixir
defmodule MyAppWeb do
  defp html_helpers do
    quote do
      use MithrilUI.Components
      # ... other imports
    end
  end
end
```

### 2. Use Components

```heex
<.button variant="primary">Click me</.button>

<.card>
  <:header>Card Title</:header>
  <:body>Card content goes here.</:body>
  <:footer>
    <.button size="sm">Action</.button>
  </:footer>
</.card>

<.modal id="my-modal">
  <:title>Confirm</:title>
  <p>Are you sure?</p>
  <:actions>
    <.button phx-click={hide_modal("my-modal")}>Cancel</.button>
    <.button variant="primary">Confirm</.button>
  </:actions>
</.modal>
```

## Component Categories

### Actions
- `button` - Buttons with variants, sizes, and states
- `button_group` - Grouped button sets
- `dropdown` - Dropdown menus

### Forms
- `input` - Text inputs with validation
- `textarea` - Multi-line text input
- `select` - Dropdown selection
- `checkbox` - Checkbox inputs
- `radio` - Radio button groups
- `toggle` - Toggle switches
- `range` - Range sliders
- `file_input` - File upload inputs

### Feedback
- `alert` - Alert messages
- `toast` - Toast notifications
- `modal` - Modal dialogs
- `drawer` - Slide-out panels
- `progress` - Progress bars
- `spinner` - Loading spinners
- `skeleton` - Content placeholders

### Data Display
- `card` - Content cards
- `table` - Data tables
- `avatar` - User avatars
- `badge` - Status badges
- `accordion` - Collapsible sections
- `list_group` - Vertical lists
- `timeline` - Event timelines

### Navigation
- `navbar` - Top navigation
- `sidebar` - Side navigation
- `breadcrumb` - Breadcrumb trails
- `tabs` - Tab navigation
- `pagination` - Page navigation
- `bottom_navigation` - Mobile bottom nav

### Overlays
- `tooltip` - Hover tooltips
- `popover` - Rich popovers

### Typography
- `heading` - Headings h1-h6
- `text` - Styled text
- `link` - Anchor links
- `blockquote` - Quotations
- `code` - Code blocks
- `kbd` - Keyboard keys

### Extended
- `rating` - Star ratings
- `stepper` - Step progress
- `indicator` - Status indicators
- `chat_bubble` - Chat messages
- `footer` - Page footers
- `banner` - Announcement banners
- `carousel` - Image carousels
- `gallery` - Image galleries

### Utility
- `theme_switcher` - Theme selection
- `clipboard` - Copy to clipboard
- `speed_dial` - Floating action buttons

## Theming

Mithril UI uses DaisyUI for theming. Configure themes in `config/mithril_ui.exs`:

```elixir
config :mithril_ui,
  default_theme: "light",
  dark_theme: "dark",
  builtin_themes: :all
```

### Custom Themes

Create custom themes with `mix mithril_ui.gen.themes`:

```elixir
config :mithril_ui,
  themes: [
    %{
      name: "corporate",
      color_scheme: :light,
      colors: %{
        primary: "#4F46E5",
        secondary: "#7C3AED",
        accent: "#F59E0B"
      }
    }
  ]
```

## AI Integration

Mithril UI includes AI-friendly component metadata for AI-assisted development:

```elixir
# List all components
MithrilUI.AI.ComponentSelector.list_components()

# Get component suggestions
MithrilUI.AI.ComponentSelector.suggest_components("form submit button")

# Get component schema
MithrilUI.AI.ComponentSelector.get_schema(:button)

# Export JSON for AI tools
MithrilUI.AI.ComponentSelector.export_json()
```

## Mix Tasks

- `mix mithril_ui.install` - Install Mithril UI in your project
- `mix mithril_ui.gen.themes` - Generate CSS from custom themes
- `mix mithril_ui.mcp` - Start MCP server for AI integration

## AI Integration (MCP)

Mithril UI includes an MCP server for AI assistants like Claude Code.

**Setup** - Add to `.mcp.json` in your project:

```json
{
  "mcpServers": {
    "mithril-ui": {
      "command": "mix",
      "args": ["mithril_ui.mcp"]
    }
  }
}
```

**Available tools:** `list_components`, `get_component`, `suggest_components`, `get_examples`, `list_categories`, `list_themes`, `get_related`

## Documentation

- [HexDocs](https://hexdocs.pm/mithril_ui)
- [Storybook](http://localhost:4000/storybook) (run `mix phx.server`)

## Requirements

- Elixir ~> 1.14
- Phoenix ~> 1.7
- Phoenix LiveView ~> 1.0
- DaisyUI ~> 4.0 (npm)

## License

MIT License - see [LICENSE](LICENSE) for details.
