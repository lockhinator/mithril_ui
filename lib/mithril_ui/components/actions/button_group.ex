defmodule MithrilUI.Components.ButtonGroup do
  @moduledoc """
  A component for grouping multiple buttons together with joined styling.

  Button groups are useful for related actions, toolbars, or segmented controls
  where multiple buttons should visually appear as a single unit.

  ## Examples

  Basic button group:

      <.button_group>
        <:button>Left</:button>
        <:button>Center</:button>
        <:button>Right</:button>
      </.button_group>

  With variants:

      <.button_group variant="primary">
        <:button>Save</:button>
        <:button>Save as Draft</:button>
      </.button_group>

  Vertical orientation:

      <.button_group orientation="vertical">
        <:button>Option 1</:button>
        <:button>Option 2</:button>
        <:button>Option 3</:button>
      </.button_group>

  ## DaisyUI Classes

  The component uses the following DaisyUI classes:
  - `join` - Base container for joined elements
  - `join-item` - Applied to each button in the group
  - `join-vertical` - Vertical orientation
  - `join-horizontal` - Horizontal orientation (default)
  """

  use Phoenix.Component

  @variants ~w(primary secondary accent ghost link outline neutral info success warning error)
  @sizes ~w(xs sm md lg)

  @doc """
  Renders a group of joined buttons.

  ## Attributes

    * `:variant` - The visual style variant applied to all buttons.
    * `:size` - The size applied to all buttons.
    * `:orientation` - horizontal or vertical. Defaults to "horizontal".
    * `:outline` - Whether to use outline style for all buttons. Defaults to false.
    * `:disabled` - Whether all buttons are disabled. Defaults to false.
    * `:class` - Additional CSS classes for the container.

  ## Slots

    * `:button` - Each button in the group (at least one required).
      - `:active` - Whether this button is in active state.
      - `:disabled` - Whether this specific button is disabled.
      - `:class` - Additional classes for this specific button.
      - Supports phx-click and other event attributes.

  ## Examples

      <.button_group variant="primary" size="sm">
        <:button phx-click="align-left">Left</:button>
        <:button phx-click="align-center" active>Center</:button>
        <:button phx-click="align-right">Right</:button>
      </.button_group>
  """
  @spec button_group(map()) :: Phoenix.LiveView.Rendered.t()

  attr :variant, :string, default: nil, values: @variants ++ [nil]
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :orientation, :string, default: "horizontal", values: ~w(horizontal vertical)
  attr :outline, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :class, :any, default: nil

  slot :button, required: true do
    attr :active, :boolean
    attr :disabled, :boolean
    attr :class, :any
    attr :type, :string
    attr :"phx-click", :any
    attr :"phx-target", :any
    attr :"phx-value-item", :any
    attr :"phx-value-id", :any
    attr :value, :any
    attr :name, :string
  end

  def button_group(assigns) do
    ~H"""
    <div class={group_classes(@orientation, @class)} role="group">
      <button
        :for={btn <- @button}
        type={Map.get(btn, :type, "button")}
        class={
          item_button_classes(
            @variant,
            @size,
            @outline,
            btn[:active],
            @disabled || btn[:disabled],
            btn[:class]
          )
        }
        disabled={@disabled || btn[:disabled]}
        {assigns_to_attributes(btn, [:active, :disabled, :class, :type, :inner_block])}
      >
        {render_slot(btn)}
      </button>
    </div>
    """
  end

  @doc """
  Renders a radio button group styled as joined buttons.

  Useful for single-selection scenarios where buttons should act like radio inputs.

  ## Attributes

    * `:name` - The form name for the radio inputs (required).
    * `:value` - The currently selected value.
    * `:options` - List of options as `[{"Label", "value"}, ...]` or keyword list.
    * `:variant` - The visual style variant.
    * `:size` - The size applied to all buttons.
    * `:orientation` - horizontal or vertical. Defaults to "horizontal".
    * `:disabled` - Whether all options are disabled.

  ## Examples

      <.radio_button_group
        name="alignment"
        value={@alignment}
        options={[{"Left", "left"}, {"Center", "center"}, {"Right", "right"}]}
        variant="primary"
      />
  """
  @spec radio_button_group(map()) :: Phoenix.LiveView.Rendered.t()

  attr :name, :string, required: true
  attr :value, :any, default: nil
  attr :options, :list, required: true
  attr :variant, :string, default: nil, values: @variants ++ [nil]
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :orientation, :string, default: "horizontal", values: ~w(horizontal vertical)
  attr :outline, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :class, :any, default: nil

  attr :rest, :global, include: ~w(phx-change form)

  def radio_button_group(assigns) do
    assigns = assign(assigns, :normalized_options, normalize_options(assigns.options))

    ~H"""
    <div class={group_classes(@orientation, @class)} role="radiogroup">
      <input
        :for={{label, opt_value} <- @normalized_options}
        type="radio"
        name={@name}
        value={opt_value}
        checked={to_string(@value) == to_string(opt_value)}
        disabled={@disabled}
        class={radio_button_classes(@variant, @size, @outline)}
        aria-label={label}
        {@rest}
      />
    </div>
    """
  end

  defp normalize_options(options) when is_list(options) do
    Enum.map(options, fn
      {label, value} -> {label, value}
      value when is_binary(value) -> {value, value}
      value when is_atom(value) -> {Atom.to_string(value), value}
    end)
  end

  defp group_classes(orientation, extra_class) do
    [
      "join",
      orientation == "vertical" && "join-vertical",
      orientation == "horizontal" && "join-horizontal",
      extra_class
    ]
  end

  defp item_button_classes(variant, size, outline, active, disabled, extra_class) do
    [
      "btn join-item",
      variant_class(variant, outline),
      size && "btn-#{size}",
      active && "btn-active",
      disabled && "btn-disabled",
      extra_class
    ]
  end

  defp radio_button_classes(variant, size, outline) do
    [
      "btn join-item",
      variant_class(variant, outline),
      size && "btn-#{size}"
    ]
  end

  defp variant_class(nil, false), do: nil
  defp variant_class(nil, true), do: "btn-outline"
  defp variant_class(variant, false), do: "btn-#{variant}"
  defp variant_class(variant, true), do: "btn-outline btn-#{variant}"
end
