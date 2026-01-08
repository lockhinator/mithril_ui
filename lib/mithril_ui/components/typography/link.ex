defmodule MithrilUI.Components.Link do
  @moduledoc """
  Link component for styled anchor elements.

  Provides consistent link styles with support for colors, underline
  behaviors, and various visual variants.

  ## Examples

  Basic link:

      <.link href="/about">About Us</.link>

  With colors:

      <.link href="/docs" color={:primary}>Documentation</.link>

  Without underline by default:

      <.link href="/page" underline={:hover}>Hover to underline</.link>

  ## Note

  This component wraps the standard Phoenix link for styling purposes.
  For navigation, consider using Phoenix.Component.link/1 directly.
  """

  use Phoenix.Component

  @doc """
  Renders a styled anchor link.

  ## Attributes

    * `:href` - Link destination URL (required).
    * `:color` - Link color. Options: `:default`, `:primary`, `:secondary`, `:accent`, `:muted`, `:neutral`.
    * `:underline` - Underline behavior. Options: `:always`, `:hover`, `:none`.
    * `:weight` - Font weight. Options: `:normal`, `:medium`, `:semibold`, `:bold`.
    * `:external` - Open in new tab. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - Required. Link text/content.

  ## Examples

      <.styled_link href="/">Home</.styled_link>
      <.styled_link href="/about" color={:primary} underline={:hover}>About</.styled_link>
      <.styled_link href="https://example.com" external>External Site</.styled_link>
  """
  @spec styled_link(map()) :: Phoenix.LiveView.Rendered.t()

  attr :href, :string, required: true, doc: "Link destination URL"

  attr :color, :atom,
    default: :primary,
    values: [:default, :primary, :secondary, :accent, :muted, :neutral],
    doc: "Link color"

  attr :underline, :atom,
    default: :hover,
    values: [:always, :hover, :none],
    doc: "Underline behavior"

  attr :weight, :atom,
    default: :medium,
    values: [:normal, :medium, :semibold, :bold],
    doc: "Font weight"

  attr :external, :boolean, default: false, doc: "Open in new tab"
  attr :class, :string, default: nil, doc: "Additional CSS classes"
  attr :rest, :global, include: ~w(download hreflang ping referrerpolicy rel type)

  slot :inner_block, required: true, doc: "Link content"

  def styled_link(assigns) do
    ~H"""
    <a
      href={@href}
      target={@external && "_blank"}
      rel={@external && "noopener noreferrer"}
      class={[
        color_class(@color),
        underline_class(@underline),
        weight_class(@weight),
        "transition-colors",
        @class
      ]}
      {@rest}
    >
      {render_slot(@inner_block)}
      <svg
        :if={@external}
        class="inline-block w-3 h-3 ml-1"
        fill="none"
        stroke="currentColor"
        viewBox="0 0 24 24"
      >
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"
        />
      </svg>
    </a>
    """
  end

  @doc """
  Renders a navigation link with active state support.

  ## Attributes

    * `:href` - Link destination URL.
    * `:active` - Whether link represents current page.
    * `:class` - Additional CSS classes.

  ## Examples

      <.nav_link href="/" active={@current_path == "/"}>Home</.nav_link>
      <.nav_link href="/about" active={@current_path == "/about"}>About</.nav_link>
  """
  @spec nav_link(map()) :: Phoenix.LiveView.Rendered.t()

  attr :href, :string, required: true, doc: "Link destination"
  attr :active, :boolean, default: false, doc: "Active state"
  attr :class, :string, default: nil, doc: "Additional CSS classes"
  attr :rest, :global

  slot :inner_block, required: true, doc: "Link content"

  def nav_link(assigns) do
    ~H"""
    <a
      href={@href}
      class={[
        "font-medium transition-colors",
        @active && "text-primary",
        !@active && "text-base-content/70 hover:text-base-content",
        @class
      ]}
      aria-current={@active && "page"}
      {@rest}
    >
      {render_slot(@inner_block)}
    </a>
    """
  end

  @doc """
  Renders a button-styled link.

  ## Attributes

    * `:href` - Link destination URL.
    * `:variant` - Button variant. Options: `:primary`, `:secondary`, `:accent`, `:ghost`, `:outline`.
    * `:size` - Button size. Options: `:xs`, `:sm`, `:md`, `:lg`.
    * `:class` - Additional CSS classes.

  ## Examples

      <.button_link href="/signup" variant={:primary}>Sign Up</.button_link>
      <.button_link href="/learn" variant={:ghost}>Learn More</.button_link>
  """
  @spec button_link(map()) :: Phoenix.LiveView.Rendered.t()

  attr :href, :string, required: true, doc: "Link destination"

  attr :variant, :atom,
    default: :primary,
    values: [:primary, :secondary, :accent, :ghost, :outline],
    doc: "Button variant"

  attr :size, :atom,
    default: :md,
    values: [:xs, :sm, :md, :lg],
    doc: "Button size"

  attr :external, :boolean, default: false, doc: "Open in new tab"
  attr :class, :string, default: nil, doc: "Additional CSS classes"
  attr :rest, :global

  slot :inner_block, required: true, doc: "Link content"

  def button_link(assigns) do
    ~H"""
    <a
      href={@href}
      target={@external && "_blank"}
      rel={@external && "noopener noreferrer"}
      class={["btn", variant_class(@variant), size_class(@size), @class]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </a>
    """
  end

  # Color classes
  defp color_class(:default), do: "text-base-content"
  defp color_class(:primary), do: "text-primary hover:text-primary-focus"
  defp color_class(:secondary), do: "text-secondary hover:text-secondary-focus"
  defp color_class(:accent), do: "text-accent hover:text-accent-focus"
  defp color_class(:muted), do: "text-base-content/60 hover:text-base-content"
  defp color_class(:neutral), do: "text-neutral hover:text-neutral-focus"

  # Underline classes
  defp underline_class(:always), do: "underline"
  defp underline_class(:hover), do: "hover:underline"
  defp underline_class(:none), do: "no-underline"

  # Weight classes
  defp weight_class(:normal), do: "font-normal"
  defp weight_class(:medium), do: "font-medium"
  defp weight_class(:semibold), do: "font-semibold"
  defp weight_class(:bold), do: "font-bold"

  # Button variant classes
  defp variant_class(:primary), do: "btn-primary"
  defp variant_class(:secondary), do: "btn-secondary"
  defp variant_class(:accent), do: "btn-accent"
  defp variant_class(:ghost), do: "btn-ghost"
  defp variant_class(:outline), do: "btn-outline"

  # Button size classes
  defp size_class(:xs), do: "btn-xs"
  defp size_class(:sm), do: "btn-sm"
  defp size_class(:md), do: nil
  defp size_class(:lg), do: "btn-lg"
end
