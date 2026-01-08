defmodule MithrilUI.Components.Badge do
  @moduledoc """
  Badge component for displaying status indicators, labels, and counts.

  ## Examples

  Basic badge:

      <.badge>New</.badge>

  With variant:

      <.badge variant="success">Active</.badge>

  Outline style:

      <.badge variant="error" outline>Urgent</.badge>

  ## DaisyUI Classes

  - `badge` - Base badge styling
  - `badge-{variant}` - Color variants
  - `badge-outline` - Outline style
  - `badge-{size}` - Size variants
  """

  use Phoenix.Component

  @variants ~w(primary secondary accent neutral ghost info success warning error)
  @sizes ~w(xs sm md lg)

  @doc """
  Renders a badge.

  ## Attributes

    * `:variant` - Color variant.
    * `:size` - Badge size: xs, sm, md, lg. Defaults to "md".
    * `:outline` - Use outline style. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Badge content (required).

  ## Examples

      <.badge variant="primary">Featured</.badge>

      <.badge variant="warning" size="lg">Important</.badge>
  """
  @spec badge(map()) :: Phoenix.LiveView.Rendered.t()

  attr :variant, :string, default: nil, values: @variants ++ [nil]
  attr :size, :string, default: "md", values: @sizes
  attr :outline, :boolean, default: false
  attr :class, :string, default: nil

  slot :inner_block, required: true

  def badge(assigns) do
    ~H"""
    <span class={badge_classes(@variant, @size, @outline, @class)}>
      {render_slot(@inner_block)}
    </span>
    """
  end

  @doc """
  Renders a badge with an optional icon.

  ## Attributes

  Same as `badge/1` plus:
    * `:icon_position` - Icon position: left, right. Defaults to "left".

  ## Slots

    * `:icon` - Icon content.
    * `:inner_block` - Badge text.

  ## Examples

      <.badge_with_icon variant="info">
        <:icon><svg>...</svg></:icon>
        Info
      </.badge_with_icon>
  """
  @spec badge_with_icon(map()) :: Phoenix.LiveView.Rendered.t()

  attr :variant, :string, default: nil, values: @variants ++ [nil]
  attr :size, :string, default: "md", values: @sizes
  attr :outline, :boolean, default: false
  attr :icon_position, :string, default: "left", values: ~w(left right)
  attr :class, :string, default: nil

  slot :icon
  slot :inner_block, required: true

  def badge_with_icon(assigns) do
    ~H"""
    <span class={badge_classes(@variant, @size, @outline, ["gap-1", @class])}>
      <span :if={@icon != [] && @icon_position == "left"} class="inline-flex">
        {render_slot(@icon)}
      </span>
      {render_slot(@inner_block)}
      <span :if={@icon != [] && @icon_position == "right"} class="inline-flex">
        {render_slot(@icon)}
      </span>
    </span>
    """
  end

  @doc """
  Renders a numeric indicator badge, typically for notification counts.

  ## Attributes

    * `:count` - The number to display.
    * `:max` - Maximum number before showing "max+". Defaults to 99.
    * `:show_zero` - Show badge when count is 0. Defaults to false.

  ## Examples

      <.indicator_badge count={5} />

      <.indicator_badge count={150} max={99} />
  """
  @spec indicator_badge(map()) :: Phoenix.LiveView.Rendered.t()

  attr :count, :integer, required: true
  attr :max, :integer, default: 99
  attr :show_zero, :boolean, default: false
  attr :variant, :string, default: "primary", values: @variants
  attr :size, :string, default: "sm", values: @sizes
  attr :class, :string, default: nil

  def indicator_badge(assigns) do
    display = if assigns.count > assigns.max, do: "#{assigns.max}+", else: "#{assigns.count}"
    assigns = assign(assigns, :display, display)

    ~H"""
    <span
      :if={@count > 0 || @show_zero}
      class={badge_classes(@variant, @size, false, @class)}
    >
      <%= @display %>
    </span>
    """
  end

  defp badge_classes(variant, size, outline, extra_class) do
    [
      "badge",
      variant && "badge-#{variant}",
      size != "md" && "badge-#{size}",
      outline && "badge-outline",
      extra_class
    ]
  end
end
