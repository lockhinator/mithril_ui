# Mithril UI Component Library

This is a Phoenix LiveView component library with DaisyUI theming.

## Project Guidelines

- Use `mix precommit` alias before committing changes (runs compile, format, test)
- All components must have tests
- All components must have proper documentation

## Component Development

### Structure

Components are organized by category in `lib/mithril_ui/components/`:

- `actions/` - Buttons, dropdowns
- `forms/` - Input, select, checkbox, etc.
- `feedback/` - Alert, modal, toast, spinner
- `data_display/` - Card, table, badge, avatar
- `navigation/` - Navbar, sidebar, tabs, pagination
- `overlays/` - Tooltip, popover
- `typography/` - Heading, text, link, code
- `extended/` - Rating, stepper, carousel, gallery
- `utility/` - Theme switcher, clipboard

### Creating Components

All components follow this pattern:

```elixir
defmodule MithrilUI.Components.MyComponent do
  @moduledoc """
  Description and examples.
  """

  use Phoenix.Component

  @doc """
  Renders the component.

  ## Attributes
  - `:attr_name` - Description. Defaults to "value".

  ## Slots
  - `:slot_name` - Description.
  """
  attr :attr_name, :string, default: "value"
  slot :slot_name

  def my_component(assigns) do
    ~H"""
    <div class={["base-class", @class]}>
      {render_slot(@slot_name)}
    </div>
    """
  end
end
```

### DaisyUI Classes

Components use DaisyUI utility classes. Common patterns:

- Base class + variant: `btn btn-primary`
- Size modifiers: `btn-xs`, `btn-sm`, `btn-md`, `btn-lg`
- State modifiers: `btn-disabled`, `loading`

### Testing Components

Use `Phoenix.Component` and `LazyHTML` for testing:

```elixir
defmodule MithrilUI.Components.MyComponentTest do
  use ExUnit.Case, async: true

  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias MithrilUI.Components.MyComponent

  test "renders with default attributes" do
    assigns = %{}
    html = rendered_to_string(~H"<MyComponent.my_component />")

    assert html =~ "base-class"
  end
end
```

## Elixir Guidelines

- Lists do not support index access via `list[i]` - use `Enum.at/2`
- Variables are immutable - bind `if`/`case` results to variables
- Never nest multiple modules in the same file
- Use `struct.field` for struct access, not `struct[:field]`

## HEEx Guidelines

- Use `{...}` for interpolation in attributes
- Use `<%= ... %>` for block constructs (if, for, case) in tag bodies
- Class lists must use `[...]` syntax: `class={["a", @condition && "b"]}`
- Never use `<%= %>` in attributes
- Comments use `<%!-- comment --%>` syntax
