defmodule MithrilUI.Components.Heading do
  @moduledoc """
  Heading component for semantic page titles and section headers.

  Provides consistent heading styles from H1 to H6 with support for
  colors, sizes, and decorations.

  ## Examples

  Basic headings:

      <.heading level={1}>Page Title</.heading>
      <.heading level={2}>Section Title</.heading>
      <.heading level={3}>Subsection</.heading>

  With custom styles:

      <.heading level={1} size={:xl} color={:primary}>
        Highlighted Title
      </.heading>

  ## Accessibility

  - Use heading levels in logical order (H1 -> H2 -> H3, etc.)
  - Only one H1 per page
  - Headings should describe the content that follows
  """

  use Phoenix.Component

  @doc """
  Renders a semantic heading element (h1-h6).

  ## Attributes

    * `:level` - Heading level (1-6). Defaults to 1.
    * `:size` - Override default size. Options: `:xs`, `:sm`, `:md`, `:lg`, `:xl`, `:2xl`, `:3xl`, `:4xl`, `:5xl`.
    * `:color` - Text color. Options: `:default`, `:primary`, `:secondary`, `:accent`, `:muted`.
    * `:weight` - Font weight. Options: `:normal`, `:medium`, `:semibold`, `:bold`, `:extrabold`.
    * `:tracking` - Letter spacing. Options: `:tighter`, `:tight`, `:normal`, `:wide`.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Required. Heading content.

  ## Examples

      <.heading level={1}>Welcome to Our App</.heading>
      <.heading level={2} color={:primary}>Features</.heading>
      <.heading level={3} weight={:medium} size={:lg}>Subsection</.heading>
  """
  @spec heading(map()) :: Phoenix.LiveView.Rendered.t()

  attr :level, :integer, default: 1, values: [1, 2, 3, 4, 5, 6], doc: "Heading level (1-6)"

  attr :size, :atom,
    default: nil,
    values: [nil, :xs, :sm, :md, :lg, :xl, :"2xl", :"3xl", :"4xl", :"5xl"],
    doc: "Override default size"

  attr :color, :atom,
    default: :default,
    values: [:default, :primary, :secondary, :accent, :muted],
    doc: "Text color"

  attr :weight, :atom,
    default: :bold,
    values: [:normal, :medium, :semibold, :bold, :extrabold],
    doc: "Font weight"

  attr :tracking, :atom,
    default: :tight,
    values: [:tighter, :tight, :normal, :wide],
    doc: "Letter spacing"

  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global, doc: "Additional HTML attributes"

  slot :inner_block, required: true, doc: "Heading content"

  def heading(assigns) do
    assigns = assign(assigns, :tag, heading_tag(assigns.level))

    ~H"""
    <.dynamic_tag
      tag_name={@tag}
      class={[
        size_class(@size, @level),
        color_class(@color),
        weight_class(@weight),
        tracking_class(@tracking),
        @class
      ]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </.dynamic_tag>
    """
  end

  # Heading tag based on level - returns string for dynamic_tag
  defp heading_tag(1), do: "h1"
  defp heading_tag(2), do: "h2"
  defp heading_tag(3), do: "h3"
  defp heading_tag(4), do: "h4"
  defp heading_tag(5), do: "h5"
  defp heading_tag(6), do: "h6"

  # Size class - if nil, use default for level
  defp size_class(nil, 1), do: "text-4xl md:text-5xl"
  defp size_class(nil, 2), do: "text-3xl md:text-4xl"
  defp size_class(nil, 3), do: "text-2xl md:text-3xl"
  defp size_class(nil, 4), do: "text-xl md:text-2xl"
  defp size_class(nil, 5), do: "text-lg md:text-xl"
  defp size_class(nil, 6), do: "text-base md:text-lg"
  defp size_class(:xs, _), do: "text-xs"
  defp size_class(:sm, _), do: "text-sm"
  defp size_class(:md, _), do: "text-base"
  defp size_class(:lg, _), do: "text-lg"
  defp size_class(:xl, _), do: "text-xl"
  defp size_class(:"2xl", _), do: "text-2xl"
  defp size_class(:"3xl", _), do: "text-3xl"
  defp size_class(:"4xl", _), do: "text-4xl"
  defp size_class(:"5xl", _), do: "text-5xl"

  # Color classes
  defp color_class(:default), do: "text-base-content"
  defp color_class(:primary), do: "text-primary"
  defp color_class(:secondary), do: "text-secondary"
  defp color_class(:accent), do: "text-accent"
  defp color_class(:muted), do: "text-base-content/70"

  # Weight classes
  defp weight_class(:normal), do: "font-normal"
  defp weight_class(:medium), do: "font-medium"
  defp weight_class(:semibold), do: "font-semibold"
  defp weight_class(:bold), do: "font-bold"
  defp weight_class(:extrabold), do: "font-extrabold"

  # Tracking classes
  defp tracking_class(:tighter), do: "tracking-tighter"
  defp tracking_class(:tight), do: "tracking-tight"
  defp tracking_class(:normal), do: "tracking-normal"
  defp tracking_class(:wide), do: "tracking-wide"
end
