defmodule MithrilUI.Components.Spinner do
  @moduledoc """
  Loading spinner component for indicating processing or loading states.

  Provides multiple spinner styles and sizes to match your UI needs.

  ## Examples

  Basic spinner:

      <.spinner />

  With size and variant:

      <.spinner size="lg" variant="primary" />

  Different types:

      <.spinner type="dots" />
      <.spinner type="ring" />
      <.spinner type="ball" />

  ## DaisyUI Classes

  - `loading` - Base loading animation
  - `loading-spinner` - Spinner animation
  - `loading-dots` - Dots animation
  - `loading-ring` - Ring animation
  - `loading-ball` - Ball animation
  - `loading-bars` - Bars animation
  - `loading-infinity` - Infinity animation
  """

  use Phoenix.Component

  @types ~w(spinner dots ring ball bars infinity)
  @sizes ~w(xs sm md lg)
  @variants ~w(primary secondary accent neutral info success warning error)

  @doc """
  Renders a loading spinner.

  ## Attributes

    * `:type` - Animation type: spinner, dots, ring, ball, bars, infinity.
      Defaults to "spinner".
    * `:size` - Size: xs, sm, md, lg. Defaults to "md".
    * `:variant` - Color variant for the spinner.
    * `:label` - Accessible label. Defaults to "Loading".
    * `:class` - Additional CSS classes.

  ## Examples

      <.spinner />

      <.spinner type="dots" size="lg" variant="primary" />

      <.spinner label="Saving changes..." />
  """
  @spec spinner(map()) :: Phoenix.LiveView.Rendered.t()

  attr :type, :string, default: "spinner", values: @types
  attr :size, :string, default: "md", values: @sizes
  attr :variant, :string, default: nil, values: @variants ++ [nil]
  attr :label, :string, default: "Loading"
  attr :class, :any, default: nil

  def spinner(assigns) do
    ~H"""
    <span
      class={spinner_classes(@type, @size, @variant, @class)}
      role="status"
      aria-label={@label}
    >
      <span class="sr-only">{@label}</span>
    </span>
    """
  end

  @doc """
  Renders a spinner with accompanying text.

  ## Attributes

  Same as `spinner/1` plus:
    * `:text` - Text to display alongside spinner.
    * `:position` - Text position: left, right, top, bottom. Defaults to "right".

  ## Examples

      <.spinner_with_text text="Loading..." />

      <.spinner_with_text text="Please wait" position="bottom" />
  """
  @spec spinner_with_text(map()) :: Phoenix.LiveView.Rendered.t()

  attr :type, :string, default: "spinner", values: @types
  attr :size, :string, default: "md", values: @sizes
  attr :variant, :string, default: nil, values: @variants ++ [nil]
  attr :text, :string, required: true
  attr :position, :string, default: "right", values: ~w(left right top bottom)
  attr :class, :any, default: nil

  def spinner_with_text(assigns) do
    ~H"""
    <div class={container_classes(@position, @class)} role="status">
      <span
        :if={@position in ["right", "bottom"]}
        class={spinner_classes(@type, @size, @variant, nil)}
        aria-hidden="true"
      />
      <span>{@text}</span>
      <span
        :if={@position in ["left", "top"]}
        class={spinner_classes(@type, @size, @variant, nil)}
        aria-hidden="true"
      />
    </div>
    """
  end

  defp spinner_classes(type, size, variant, extra_class) do
    [
      "loading",
      "loading-#{type}",
      size_class(size),
      variant && "text-#{variant}",
      extra_class
    ]
  end

  defp size_class("xs"), do: "loading-xs"
  defp size_class("sm"), do: "loading-sm"
  defp size_class("md"), do: "loading-md"
  defp size_class("lg"), do: "loading-lg"

  defp container_classes(position, extra_class) do
    [
      "inline-flex items-center gap-2",
      position in ["top", "bottom"] && "flex-col",
      extra_class
    ]
  end
end
