defmodule MithrilUI.Components.Tooltip do
  @moduledoc """
  Tooltip component for displaying contextual information on hover.

  Tooltips are small pop-ups that appear when users hover over an element,
  providing additional context or information.

  ## Examples

  Basic tooltip with text:

      <.tooltip text="This is helpful information">
        <button class="btn">Hover me</button>
      </.tooltip>

  Tooltip with different positions:

      <.tooltip text="Top tooltip" position={:top}>...</.tooltip>
      <.tooltip text="Bottom tooltip" position={:bottom}>...</.tooltip>
      <.tooltip text="Left tooltip" position={:left}>...</.tooltip>
      <.tooltip text="Right tooltip" position={:right}>...</.tooltip>

  Colored tooltips:

      <.tooltip text="Primary tooltip" color={:primary}>...</.tooltip>
      <.tooltip text="Error tooltip" color={:error}>...</.tooltip>

  Always open tooltip:

      <.tooltip text="Always visible" open>...</.tooltip>

  ## DaisyUI Classes

  - `tooltip` - Base tooltip wrapper
  - `tooltip-top` / `tooltip-bottom` / `tooltip-left` / `tooltip-right` - Position
  - `tooltip-primary` / `tooltip-secondary` / etc. - Colors
  - `tooltip-open` - Force tooltip to always show
  """

  use Phoenix.Component

  @doc """
  Renders a tooltip wrapper around content.

  ## Attributes

    * `:text` - Required. The tooltip text to display.
    * `:position` - Tooltip position. Defaults to `:top`.
      Options: `:top`, `:bottom`, `:left`, `:right`.
    * `:color` - Tooltip color variant.
      Options: `:neutral`, `:primary`, `:secondary`, `:accent`,
               `:info`, `:success`, `:warning`, `:error`.
    * `:open` - Force tooltip to always be visible. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Required. The trigger element that shows the tooltip.

  ## Examples

      <.tooltip text="Click to save your changes">
        <button class="btn btn-primary">Save</button>
      </.tooltip>

      <.tooltip text="Required field" color={:error} position={:right}>
        <span class="text-error">*</span>
      </.tooltip>
  """
  @spec tooltip(map()) :: Phoenix.LiveView.Rendered.t()

  attr :text, :string, required: true, doc: "Tooltip text content"

  attr :position, :atom,
    default: :top,
    values: [:top, :bottom, :left, :right],
    doc: "Position relative to trigger element"

  attr :color, :atom,
    default: nil,
    values: [nil, :neutral, :primary, :secondary, :accent, :info, :success, :warning, :error],
    doc: "Color variant"

  attr :open, :boolean, default: false, doc: "Force tooltip to always be visible"
  attr :class, :string, default: nil, doc: "Additional CSS classes"

  slot :inner_block, required: true, doc: "Trigger element"

  def tooltip(assigns) do
    ~H"""
    <div
      class={[
        "tooltip",
        position_class(@position),
        color_class(@color),
        @open && "tooltip-open",
        @class
      ]}
      data-tip={@text}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  @doc """
  Renders a tooltip with custom HTML content instead of plain text.

  Use this variant when you need rich content like icons, formatted text,
  or interactive elements in the tooltip.

  ## Attributes

    * `:position` - Tooltip position. Defaults to `:top`.
    * `:color` - Tooltip color variant.
    * `:open` - Force tooltip to always be visible.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:content` - Required. The tooltip content (can include HTML).
    * `:inner_block` - Required. The trigger element.

  ## Examples

      <.tooltip_content position={:bottom}>
        <:content>
          <div class="flex items-center gap-2">
            <.icon name="info" class="w-4 h-4" />
            <span>More information here</span>
          </div>
        </:content>
        <button class="btn">Hover me</button>
      </.tooltip_content>
  """
  @spec tooltip_content(map()) :: Phoenix.LiveView.Rendered.t()

  attr :position, :atom,
    default: :top,
    values: [:top, :bottom, :left, :right],
    doc: "Position relative to trigger element"

  attr :color, :atom,
    default: nil,
    values: [nil, :neutral, :primary, :secondary, :accent, :info, :success, :warning, :error],
    doc: "Color variant"

  attr :open, :boolean, default: false, doc: "Force tooltip to always be visible"
  attr :class, :string, default: nil, doc: "Additional CSS classes"

  slot :content, required: true, doc: "Rich tooltip content"
  slot :inner_block, required: true, doc: "Trigger element"

  def tooltip_content(assigns) do
    ~H"""
    <div class={[
      "tooltip",
      position_class(@position),
      color_class(@color),
      @open && "tooltip-open",
      @class
    ]}>
      <div class="tooltip-content">
        {render_slot(@content)}
      </div>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # Position class helpers
  defp position_class(:top), do: "tooltip-top"
  defp position_class(:bottom), do: "tooltip-bottom"
  defp position_class(:left), do: "tooltip-left"
  defp position_class(:right), do: "tooltip-right"

  # Color class helpers
  defp color_class(nil), do: nil
  defp color_class(:neutral), do: "tooltip-neutral"
  defp color_class(:primary), do: "tooltip-primary"
  defp color_class(:secondary), do: "tooltip-secondary"
  defp color_class(:accent), do: "tooltip-accent"
  defp color_class(:info), do: "tooltip-info"
  defp color_class(:success), do: "tooltip-success"
  defp color_class(:warning), do: "tooltip-warning"
  defp color_class(:error), do: "tooltip-error"
end
