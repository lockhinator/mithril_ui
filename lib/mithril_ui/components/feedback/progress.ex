defmodule MithrilUI.Components.Progress do
  @moduledoc """
  Progress bar component for displaying completion status.

  Supports determinate (with value) and indeterminate (loading) states,
  with optional labels and semantic color variants.

  ## Examples

  Basic progress:

      <.progress value={75} max={100} />

  With label:

      <.progress value={3} max={10} label="Step 3 of 10" />

  Indeterminate loading:

      <.progress />

  Semantic variants:

      <.progress value={100} max={100} variant="success" />
      <.progress value={25} max={100} variant="warning" />

  ## DaisyUI Classes

  - `progress` - Base progress bar styling
  - `progress-primary` - Primary color
  - `progress-secondary` - Secondary color
  - `progress-accent` - Accent color
  - `progress-info` - Info color
  - `progress-success` - Success color
  - `progress-warning` - Warning color
  - `progress-error` - Error color
  """

  use Phoenix.Component

  @variants ~w(primary secondary accent info success warning error)

  @doc """
  Renders a progress bar.

  ## Attributes

    * `:value` - Current progress value (omit for indeterminate).
    * `:max` - Maximum value. Defaults to 100.
    * `:variant` - Color variant.
    * `:label` - Optional label text above the bar.
    * `:show_percentage` - Show percentage text. Defaults to false.
    * `:size` - Height size: xs, sm, md, lg. Defaults to "md".
    * `:class` - Additional CSS classes.

  ## Examples

      <.progress value={50} max={100} variant="primary" show_percentage />

      <.progress label="Uploading..." />
  """
  @spec progress(map()) :: Phoenix.LiveView.Rendered.t()

  attr :value, :integer, default: nil
  attr :max, :integer, default: 100
  attr :variant, :string, default: nil, values: @variants ++ [nil]
  attr :label, :string, default: nil
  attr :show_percentage, :boolean, default: false
  attr :size, :string, default: "md", values: ~w(xs sm md lg)
  attr :class, :any, default: nil

  def progress(assigns) do
    percentage = if assigns.value, do: round(assigns.value / assigns.max * 100), else: nil
    assigns = assign(assigns, :percentage, percentage)

    ~H"""
    <div class="w-full">
      <div :if={@label || @show_percentage} class="flex justify-between mb-1">
        <span :if={@label} class="text-sm font-medium">{@label}</span>
        <span :if={@show_percentage && @percentage} class="text-sm font-medium">
          {@percentage}%
        </span>
      </div>
      <progress
        class={progress_classes(@variant, @size, @class)}
        value={@value}
        max={@max}
        aria-valuenow={@value}
        aria-valuemin="0"
        aria-valuemax={@max}
        role="progressbar"
      />
    </div>
    """
  end

  @doc """
  Renders a radial progress indicator.

  ## Attributes

    * `:value` - Progress percentage (0-100).
    * `:size` - Size in rem or CSS units. Defaults to "4rem".
    * `:thickness` - Border thickness. Defaults to "4px".
    * `:variant` - Color variant.
    * `:class` - Additional CSS classes.

  ## Examples

      <.radial_progress value={70} />

      <.radial_progress value={100} variant="success" size="6rem" />
  """
  @spec radial_progress(map()) :: Phoenix.LiveView.Rendered.t()

  attr :value, :integer, required: true
  attr :size, :string, default: "4rem"
  attr :thickness, :string, default: "4px"
  attr :variant, :string, default: nil, values: @variants ++ [nil]
  attr :class, :any, default: nil

  slot :inner_block

  def radial_progress(assigns) do
    ~H"""
    <div
      class={radial_classes(@variant, @class)}
      style={"--value:#{@value}; --size:#{@size}; --thickness:#{@thickness}"}
      role="progressbar"
      aria-valuenow={@value}
      aria-valuemin="0"
      aria-valuemax="100"
    >
      <%= if @inner_block == [] do %>
        {@value}%
      <% else %>
        {render_slot(@inner_block)}
      <% end %>
    </div>
    """
  end

  defp progress_classes(variant, size, extra_class) do
    [
      "progress w-full",
      variant && "progress-#{variant}",
      size_class(size),
      extra_class
    ]
  end

  defp size_class("xs"), do: "h-1"
  defp size_class("sm"), do: "h-2"
  defp size_class("md"), do: "h-3"
  defp size_class("lg"), do: "h-4"

  defp radial_classes(variant, extra_class) do
    [
      "radial-progress",
      variant && "text-#{variant}",
      extra_class
    ]
  end
end
