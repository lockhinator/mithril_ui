defmodule MithrilUI.Components.Button do
  @moduledoc """
  A versatile button component with multiple variants, sizes, and states.

  Supports all DaisyUI button styles and integrates seamlessly with Phoenix LiveView
  for handling click events and form submissions.

  ## Examples

  Basic button:

      <.button>Click me</.button>

  Primary button with icon:

      <.button variant="primary">
        <.icon name="hero-plus" class="w-4 h-4 mr-2" />
        Add Item
      </.button>

  Loading state:

      <.button loading>Processing...</.button>

  Link-style button:

      <.button variant="link" navigate="/dashboard">Go to Dashboard</.button>

  ## DaisyUI Classes

  The component uses the following DaisyUI classes:
  - `btn` - Base button styling
  - `btn-{variant}` - primary, secondary, accent, ghost, link, outline, neutral, info, success, warning, error
  - `btn-{size}` - xs, sm, md, lg
  - `btn-disabled` - Applied when disabled
  - `btn-block` - Full width button
  - `btn-circle` - Circular button
  - `btn-square` - Square button

  ## Accessibility

  - Buttons are properly focusable with keyboard navigation
  - Disabled state is conveyed via `aria-disabled`
  - Loading state is conveyed via `aria-busy`
  """

  use Phoenix.Component

  @variants ~w(primary secondary accent ghost link outline neutral info success warning error)
  @sizes ~w(xs sm md lg)

  @doc """
  Renders a styled button with configurable variant, size, and state.

  ## Attributes

    * `:type` - The button type. Defaults to "button".
      Supported types: button, submit, reset.
    * `:variant` - The visual style variant.
      Supported variants: #{Enum.join(@variants, ", ")}.
    * `:size` - The button size.
      Supported sizes: #{Enum.join(@sizes, ", ")}.
    * `:disabled` - Whether the button is disabled. Defaults to false.
    * `:loading` - Whether to show loading spinner. Defaults to false.
    * `:block` - Whether button should be full width. Defaults to false.
    * `:circle` - Whether button should be circular. Defaults to false.
    * `:square` - Whether button should be square. Defaults to false.
    * `:outline` - Whether to use outline style (can combine with variant). Defaults to false.
    * `:class` - Additional CSS classes for the button element.
    * Global attributes like `phx-click`, `navigate`, `patch`, `href`, etc. are passed through.

  ## Slots

    * `:inner_block` - The button content (required).

  ## Examples

      <.button type="submit" variant="primary">Submit Form</.button>

      <.button variant="ghost" size="sm" phx-click="toggle">
        Toggle
      </.button>

      <.button loading disabled>
        Saving...
      </.button>
  """
  @spec button(map()) :: Phoenix.LiveView.Rendered.t()

  attr :type, :string, default: "button", values: ~w(button submit reset)
  attr :variant, :string, default: nil, values: @variants ++ [nil]
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :disabled, :boolean, default: false
  attr :loading, :boolean, default: false
  attr :block, :boolean, default: false
  attr :circle, :boolean, default: false
  attr :square, :boolean, default: false
  attr :outline, :boolean, default: false
  attr :class, :string, default: nil

  attr :rest, :global,
    include: ~w(navigate patch href download hreflang referrerpolicy rel target type form name value phx-click phx-target phx-disable-with phx-page-loading)

  slot :inner_block, required: true

  def button(assigns) do
    ~H"""
    <button
      type={@type}
      disabled={@disabled || @loading}
      class={button_classes(@variant, @size, @disabled, @loading, @block, @circle, @square, @outline, @class)}
      aria-disabled={@disabled || @loading}
      aria-busy={@loading}
      {@rest}
    >
      <span :if={@loading} class="loading loading-spinner"></span>
      {render_slot(@inner_block)}
    </button>
    """
  end

  @doc """
  Renders a button that looks like a link or navigates using LiveView.

  This is useful when you want button styling but link behavior.

  ## Attributes

  Same as `button/1` plus navigation attributes.

  ## Examples

      <.link_button navigate="/users">View Users</.link_button>

      <.link_button href="https://example.com" target="_blank">
        External Link
      </.link_button>
  """
  @spec link_button(map()) :: Phoenix.LiveView.Rendered.t()

  attr :variant, :string, default: nil, values: @variants ++ [nil]
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :disabled, :boolean, default: false
  attr :loading, :boolean, default: false
  attr :block, :boolean, default: false
  attr :circle, :boolean, default: false
  attr :square, :boolean, default: false
  attr :outline, :boolean, default: false
  attr :class, :string, default: nil

  attr :rest, :global,
    include: ~w(navigate patch href download hreflang referrerpolicy rel target)

  slot :inner_block, required: true

  def link_button(assigns) do
    ~H"""
    <.link
      class={button_classes(@variant, @size, @disabled, @loading, @block, @circle, @square, @outline, @class)}
      aria-disabled={@disabled || @loading}
      aria-busy={@loading}
      {@rest}
    >
      <span :if={@loading} class="loading loading-spinner"></span>
      {render_slot(@inner_block)}
    </.link>
    """
  end

  @doc """
  Renders an icon-only button.

  Automatically applies appropriate sizing and shape for icon buttons.

  ## Attributes

    * `:label` - Accessible label for screen readers (required for accessibility).

  ## Examples

      <.icon_button label="Delete item" variant="error" phx-click="delete">
        <.icon name="hero-trash" class="w-5 h-5" />
      </.icon_button>

      <.icon_button label="Add" circle variant="primary">
        <.icon name="hero-plus" class="w-6 h-6" />
      </.icon_button>
  """
  @spec icon_button(map()) :: Phoenix.LiveView.Rendered.t()

  attr :label, :string, required: true, doc: "Accessible label for the button"
  attr :type, :string, default: "button", values: ~w(button submit reset)
  attr :variant, :string, default: nil, values: @variants ++ [nil]
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :disabled, :boolean, default: false
  attr :loading, :boolean, default: false
  attr :circle, :boolean, default: false
  attr :square, :boolean, default: true
  attr :outline, :boolean, default: false
  attr :class, :string, default: nil

  attr :rest, :global,
    include: ~w(navigate patch href download hreflang referrerpolicy rel target type form name value phx-click phx-target phx-disable-with phx-page-loading)

  slot :inner_block, required: true

  def icon_button(assigns) do
    ~H"""
    <button
      type={@type}
      disabled={@disabled || @loading}
      class={button_classes(@variant, @size, @disabled, @loading, false, @circle, @square, @outline, @class)}
      aria-disabled={@disabled || @loading}
      aria-busy={@loading}
      aria-label={@label}
      title={@label}
      {@rest}
    >
      <span :if={@loading} class="loading loading-spinner"></span>
      <span :if={!@loading}>
        {render_slot(@inner_block)}
      </span>
    </button>
    """
  end

  defp button_classes(variant, size, disabled, loading, block, circle, square, outline, extra_class) do
    [
      "btn",
      variant_class(variant, outline),
      size && "btn-#{size}",
      (disabled || loading) && "btn-disabled",
      block && "btn-block",
      circle && "btn-circle",
      square && !circle && "btn-square",
      extra_class
    ]
  end

  defp variant_class(nil, false), do: nil
  defp variant_class(nil, true), do: "btn-outline"
  defp variant_class(variant, false), do: "btn-#{variant}"
  defp variant_class(variant, true), do: "btn-outline btn-#{variant}"
end
