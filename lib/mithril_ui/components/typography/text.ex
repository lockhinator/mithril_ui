defmodule MithrilUI.Components.Text do
  @moduledoc """
  Text component for paragraphs and inline text styling.

  Provides consistent text styles with control over size, weight,
  color, alignment, and decorations.

  ## Examples

  Basic paragraph:

      <.text>This is a paragraph of text.</.text>

  With styles:

      <.text size={:lg} color={:muted} align={:center}>
        Centered muted text
      </.text>

  As a span:

      <.text tag={:span} weight={:semibold} color={:primary}>
        Highlighted
      </.text>
  """

  use Phoenix.Component

  @doc """
  Renders a text element with consistent styling.

  ## Attributes

    * `:tag` - HTML element to use. Defaults to `:p`.
    * `:size` - Text size. Options: `:xs`, `:sm`, `:base`, `:lg`, `:xl`.
    * `:color` - Text color. Options: `:default`, `:primary`, `:secondary`, `:accent`, `:muted`, `:success`, `:warning`, `:error`, `:info`.
    * `:weight` - Font weight. Options: `:thin`, `:light`, `:normal`, `:medium`, `:semibold`, `:bold`.
    * `:align` - Text alignment. Options: `:left`, `:center`, `:right`, `:justify`.
    * `:leading` - Line height. Options: `:tight`, `:snug`, `:normal`, `:relaxed`, `:loose`.
    * `:italic` - Render in italic. Defaults to false.
    * `:underline` - Add underline. Defaults to false.
    * `:strikethrough` - Add strikethrough. Defaults to false.
    * `:uppercase` - Transform to uppercase. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Required. Text content.

  ## Examples

      <.text>Regular paragraph text</.text>
      <.text size={:sm} color={:muted}>Small muted text</.text>
      <.text weight={:bold} underline>Important text</.text>
  """
  @spec text(map()) :: Phoenix.LiveView.Rendered.t()

  attr :tag, :string, default: "p", values: ["p", "span", "div"], doc: "HTML element to use"

  attr :size, :atom,
    default: :base,
    values: [:xs, :sm, :base, :lg, :xl],
    doc: "Text size"

  attr :color, :atom,
    default: :default,
    values: [:default, :primary, :secondary, :accent, :muted, :success, :warning, :error, :info],
    doc: "Text color"

  attr :weight, :atom,
    default: :normal,
    values: [:thin, :light, :normal, :medium, :semibold, :bold],
    doc: "Font weight"

  attr :align, :atom,
    default: nil,
    values: [nil, :left, :center, :right, :justify],
    doc: "Text alignment"

  attr :leading, :atom,
    default: :normal,
    values: [:tight, :snug, :normal, :relaxed, :loose],
    doc: "Line height"

  attr :italic, :boolean, default: false, doc: "Render in italic"
  attr :underline, :boolean, default: false, doc: "Add underline"
  attr :strikethrough, :boolean, default: false, doc: "Add strikethrough"
  attr :uppercase, :boolean, default: false, doc: "Transform to uppercase"
  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global, doc: "Additional HTML attributes"

  slot :inner_block, required: true, doc: "Text content"

  def text(assigns) do
    ~H"""
    <.dynamic_tag
      tag_name={@tag}
      class={[
        size_class(@size),
        color_class(@color),
        weight_class(@weight),
        align_class(@align),
        leading_class(@leading),
        @italic && "italic",
        @underline && "underline",
        @strikethrough && "line-through",
        @uppercase && "uppercase",
        @class
      ]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </.dynamic_tag>
    """
  end

  # Phoenix.Component.dynamic_tag is used directly, no local helper needed

  @doc """
  Renders a lead/intro paragraph with larger styling.

  ## Attributes

    * `:class` - Additional CSS classes.

  ## Examples

      <.lead>
        This is an introductory paragraph that stands out from the rest.
      </.lead>
  """
  @spec lead(map()) :: Phoenix.LiveView.Rendered.t()

  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global, doc: "Additional HTML attributes"

  slot :inner_block, required: true, doc: "Lead content"

  def lead(assigns) do
    ~H"""
    <p class={["text-xl text-base-content/80 leading-relaxed", @class]} {@rest}>
      {render_slot(@inner_block)}
    </p>
    """
  end

  @doc """
  Renders small/fine print text.

  ## Examples

      <.small>Terms and conditions apply.</.small>
  """
  @spec small(map()) :: Phoenix.LiveView.Rendered.t()

  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global, doc: "Additional HTML attributes"

  slot :inner_block, required: true, doc: "Small text content"

  def small(assigns) do
    ~H"""
    <small class={["text-sm text-base-content/60", @class]} {@rest}>
      {render_slot(@inner_block)}
    </small>
    """
  end

  @doc """
  Renders a highlighted/marked text span.

  ## Attributes

    * `:color` - Highlight color. Options: `:default`, `:primary`, `:secondary`, `:accent`.

  ## Examples

      <.mark>highlighted text</.mark>
      <.mark color={:primary}>primary highlight</.mark>
  """
  @spec mark(map()) :: Phoenix.LiveView.Rendered.t()

  attr :color, :atom,
    default: :default,
    values: [:default, :primary, :secondary, :accent],
    doc: "Highlight color"

  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global, doc: "Additional HTML attributes"

  slot :inner_block, required: true, doc: "Marked content"

  def mark(assigns) do
    ~H"""
    <mark class={[mark_color_class(@color), "px-1 rounded", @class]} {@rest}>
      {render_slot(@inner_block)}
    </mark>
    """
  end

  # Size classes
  defp size_class(:xs), do: "text-xs"
  defp size_class(:sm), do: "text-sm"
  defp size_class(:base), do: "text-base"
  defp size_class(:lg), do: "text-lg"
  defp size_class(:xl), do: "text-xl"

  # Color classes
  defp color_class(:default), do: "text-base-content"
  defp color_class(:primary), do: "text-primary"
  defp color_class(:secondary), do: "text-secondary"
  defp color_class(:accent), do: "text-accent"
  defp color_class(:muted), do: "text-base-content/60"
  defp color_class(:success), do: "text-success"
  defp color_class(:warning), do: "text-warning"
  defp color_class(:error), do: "text-error"
  defp color_class(:info), do: "text-info"

  # Weight classes
  defp weight_class(:thin), do: "font-thin"
  defp weight_class(:light), do: "font-light"
  defp weight_class(:normal), do: "font-normal"
  defp weight_class(:medium), do: "font-medium"
  defp weight_class(:semibold), do: "font-semibold"
  defp weight_class(:bold), do: "font-bold"

  # Alignment classes
  defp align_class(nil), do: nil
  defp align_class(:left), do: "text-left"
  defp align_class(:center), do: "text-center"
  defp align_class(:right), do: "text-right"
  defp align_class(:justify), do: "text-justify"

  # Line height classes
  defp leading_class(:tight), do: "leading-tight"
  defp leading_class(:snug), do: "leading-snug"
  defp leading_class(:normal), do: "leading-normal"
  defp leading_class(:relaxed), do: "leading-relaxed"
  defp leading_class(:loose), do: "leading-loose"

  # Mark color classes
  defp mark_color_class(:default), do: "bg-yellow-200 text-yellow-900"
  defp mark_color_class(:primary), do: "bg-primary text-primary-content"
  defp mark_color_class(:secondary), do: "bg-secondary text-secondary-content"
  defp mark_color_class(:accent), do: "bg-accent text-accent-content"
end
