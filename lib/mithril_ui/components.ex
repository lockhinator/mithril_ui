defmodule MithrilUI.Components do
  @moduledoc """
  Main entry point for importing Mithril UI components.

  ## Usage

  Import all components:

      use MithrilUI.Components

  Import specific categories:

      use MithrilUI.Components, only: [:forms, :feedback]

  Import individual components:

      import MithrilUI.Components.Button
      import MithrilUI.Components.Card

  ## Available Categories

  - `:actions` - Button, ButtonGroup, Dropdown
  - `:navigation` - Navbar, Sidebar, Breadcrumb, Pagination, Tabs, BottomNavigation
  - `:data_display` - Card, Table, Avatar, Badge, Accordion, ListGroup, Timeline
  - `:feedback` - Alert, Toast, Modal, Drawer, Progress, Spinner, Skeleton
  - `:forms` - Input, Textarea, Select, Checkbox, Radio, Toggle, Range, FileInput
  - `:typography` - Heading, Text, Link, Blockquote, Code, Kbd
  - `:overlays` - Tooltip, Popover
  - `:extended` - Rating, Indicator, Stepper, Gallery, Banner, ChatBubble, Footer, Carousel
  - `:utility` - ThemeSwitcher, Clipboard, SpeedDial
  """

  defmacro __using__(opts) do
    categories = Keyword.get(opts, :only, :all)

    quote do
      # Always import the base Phoenix.Component
      use Phoenix.Component

      # Import animations for use with LiveView.JS
      import MithrilUI.Animations

      unquote(import_components(categories))
    end
  end

  defp import_components(:all) do
    quote do
      # Actions
      import MithrilUI.Components.Button
      import MithrilUI.Components.ButtonGroup
      import MithrilUI.Components.Dropdown

      # Navigation
      import MithrilUI.Components.Navbar
      import MithrilUI.Components.Sidebar
      import MithrilUI.Components.Breadcrumb
      import MithrilUI.Components.Pagination
      import MithrilUI.Components.Tabs
      import MithrilUI.Components.BottomNavigation

      # Data Display
      import MithrilUI.Components.Card
      import MithrilUI.Components.Table
      import MithrilUI.Components.Avatar
      import MithrilUI.Components.Badge
      import MithrilUI.Components.Accordion
      import MithrilUI.Components.ListGroup
      import MithrilUI.Components.Timeline

      # Feedback
      import MithrilUI.Components.Alert
      import MithrilUI.Components.Toast
      import MithrilUI.Components.Modal
      import MithrilUI.Components.Drawer
      import MithrilUI.Components.Progress
      import MithrilUI.Components.Spinner
      import MithrilUI.Components.Skeleton

      # Forms
      import MithrilUI.Components.Input
      import MithrilUI.Components.Textarea
      import MithrilUI.Components.Select
      import MithrilUI.Components.Checkbox
      import MithrilUI.Components.Radio
      import MithrilUI.Components.Toggle
      import MithrilUI.Components.Range
      import MithrilUI.Components.FileInput

      # Typography
      import MithrilUI.Components.Heading
      import MithrilUI.Components.Text
      import MithrilUI.Components.Link
      import MithrilUI.Components.Blockquote
      import MithrilUI.Components.Code
      import MithrilUI.Components.Kbd

      # Overlays
      import MithrilUI.Components.Tooltip
      import MithrilUI.Components.Popover

      # Extended
      import MithrilUI.Components.Rating
      import MithrilUI.Components.Indicator
      import MithrilUI.Components.Stepper
      import MithrilUI.Components.Gallery
      import MithrilUI.Components.Banner
      import MithrilUI.Components.ChatBubble
      import MithrilUI.Components.Footer
      import MithrilUI.Components.Carousel

      # Utility
      import MithrilUI.Components.ThemeSwitcher
      import MithrilUI.Components.Clipboard
      import MithrilUI.Components.SpeedDial
    end
  end

  defp import_components(categories) when is_list(categories) do
    imports =
      for category <- categories do
        case category do
          :actions ->
            quote do
              import MithrilUI.Components.Button
              import MithrilUI.Components.ButtonGroup
              import MithrilUI.Components.Dropdown
            end

          :navigation ->
            quote do
              import MithrilUI.Components.Navbar
              import MithrilUI.Components.Sidebar
              import MithrilUI.Components.Breadcrumb
              import MithrilUI.Components.Pagination
              import MithrilUI.Components.Tabs
              import MithrilUI.Components.BottomNavigation
            end

          :data_display ->
            quote do
              import MithrilUI.Components.Card
              import MithrilUI.Components.Table
              import MithrilUI.Components.Avatar
              import MithrilUI.Components.Badge
              import MithrilUI.Components.Accordion
              import MithrilUI.Components.ListGroup
              import MithrilUI.Components.Timeline
            end

          :feedback ->
            quote do
              import MithrilUI.Components.Alert
              import MithrilUI.Components.Toast
              import MithrilUI.Components.Modal
              import MithrilUI.Components.Drawer
              import MithrilUI.Components.Progress
              import MithrilUI.Components.Spinner
              import MithrilUI.Components.Skeleton
            end

          :forms ->
            quote do
              import MithrilUI.Components.Input
              import MithrilUI.Components.Textarea
              import MithrilUI.Components.Select
              import MithrilUI.Components.Checkbox
              import MithrilUI.Components.Radio
              import MithrilUI.Components.Toggle
              import MithrilUI.Components.Range
              import MithrilUI.Components.FileInput
            end

          :typography ->
            quote do
              import MithrilUI.Components.Heading
              import MithrilUI.Components.Text
              import MithrilUI.Components.Link
              import MithrilUI.Components.Blockquote
              import MithrilUI.Components.Code
              import MithrilUI.Components.Kbd
            end

          :overlays ->
            quote do
              import MithrilUI.Components.Tooltip
              import MithrilUI.Components.Popover
            end

          :extended ->
            quote do
              import MithrilUI.Components.Rating
              import MithrilUI.Components.Indicator
              import MithrilUI.Components.Stepper
              import MithrilUI.Components.Gallery
              import MithrilUI.Components.Banner
              import MithrilUI.Components.ChatBubble
              import MithrilUI.Components.Footer
              import MithrilUI.Components.Carousel
            end

          :utility ->
            quote do
              import MithrilUI.Components.ThemeSwitcher
              import MithrilUI.Components.Clipboard
              import MithrilUI.Components.SpeedDial
            end

          _ ->
            quote do
            end
        end
      end

    quote do
      (unquote_splicing(imports))
    end
  end
end
