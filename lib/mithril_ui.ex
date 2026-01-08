defmodule MithrilUI do
  @moduledoc """
  Mithril UI - A comprehensive Phoenix LiveView component library.

  > *"As light as a feather, and as hard as dragon scales"* - Components of legendary strength

  ## Features

  - **50+ Components** - Flowbite-inspired components for Phoenix LiveView
  - **DaisyUI Theming** - 35 built-in themes + custom theme support
  - **Phoenix Form Integration** - Works seamlessly with Phoenix.HTML.FormField
  - **Animation System** - LiveView.JS presets for smooth transitions
  - **AI-Friendly** - Rich semantic metadata for AI tool selection
  - **Phoenix Storybook** - Interactive documentation for all components

  ## Quick Start

  Add Mithril UI to your dependencies:

      {:mithril_ui, "~> 0.1.0"}

  Import components in your module:

      use MithrilUI.Components

  Or import specific categories:

      use MithrilUI.Components, only: [:forms, :feedback]

  ## Configuration

      # config/config.exs
      config :mithril_ui,
        default_theme: "light",
        dark_theme: "dark",
        available_themes: :all

  ## Component Categories

  - **Actions** - Button, ButtonGroup, Dropdown, SpeedDial, Clipboard
  - **Navigation** - Navbar, Sidebar, Breadcrumb, Pagination, Tabs, BottomNavigation
  - **Data Display** - Card, Table, Avatar, Badge, Accordion, ListGroup, Timeline
  - **Feedback** - Alert, Toast, Modal, Drawer, Progress, Spinner, Skeleton
  - **Forms** - Input, Textarea, Select, Checkbox, Radio, Toggle, Range, FileInput
  - **Typography** - Heading, Text, Link, Blockquote, Code, Kbd
  """
end
