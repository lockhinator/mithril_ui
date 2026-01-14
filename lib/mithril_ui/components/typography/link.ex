defmodule MithrilUI.Components.Link do
  @moduledoc """
  Link component for styled anchor elements with full Phoenix LiveView support.

  Provides consistent link styles with support for variants, underline
  behaviors, and various visual options. Supports both traditional `href`
  links and LiveView navigation via `navigate` and `patch`.

  ## Examples

  Basic link with href:

      <.styled_link href="/about">About Us</.styled_link>

  LiveView navigation (client-side, no page reload):

      <.styled_link navigate={~p"/dashboard"}>Dashboard</.styled_link>

  LiveView patch (updates URL without remounting):

      <.styled_link patch={~p"/users?page=2"}>Page 2</.styled_link>

  With variants:

      <.styled_link href="/docs" variant={:primary}>Documentation</.styled_link>

  External link (opens in new tab):

      <.styled_link href="https://example.com" external>External Site</.styled_link>
  """

  use Phoenix.Component

  @doc """
  Renders a styled link with support for LiveView navigation.

  Supports three navigation modes:
  - `href` - Traditional link (full page navigation)
  - `navigate` - LiveView client-side navigation (remounts LiveView)
  - `patch` - LiveView patch (updates URL, triggers handle_params)

  ## Attributes

    * `:href` - Link destination URL for traditional navigation.
    * `:navigate` - LiveView navigate path (client-side navigation with remount).
    * `:patch` - LiveView patch path (updates URL without remount).
    * `:variant` - Link variant. Options: `:default`, `:primary`, `:secondary`, `:accent`, `:muted`, `:neutral`.
    * `:underline` - Underline behavior. Options: `:always`, `:hover`, `:none`.
    * `:weight` - Font weight. Options: `:normal`, `:medium`, `:semibold`, `:bold`.
    * `:external` - Open in new tab (only applies to href links). Defaults to false.
    * `:class` - Additional CSS classes.

  One of `href`, `navigate`, or `patch` must be provided.

  ## Slots

    * `:inner_block` - Required. Link text/content.

  ## Examples

      <.styled_link href="/">Home</.styled_link>
      <.styled_link navigate={~p"/dashboard"}>Dashboard</.styled_link>
      <.styled_link patch={~p"/users?sort=name"}>Sort by Name</.styled_link>
      <.styled_link href="/about" variant={:primary} underline={:hover}>About</.styled_link>
      <.styled_link href="https://example.com" external>External Site</.styled_link>
  """
  @spec styled_link(map()) :: Phoenix.LiveView.Rendered.t()

  attr :href, :string, default: nil, doc: "Link destination URL for traditional navigation"
  attr :navigate, :string, default: nil, doc: "LiveView navigate path"
  attr :patch, :string, default: nil, doc: "LiveView patch path"

  attr :variant, :any,
    default: :primary,
    values: [:default, :primary, :secondary, :accent, :muted, :neutral, "default", "primary", "secondary", "accent", "muted", "neutral"],
    doc: "Link variant (atom or string)"

  attr :underline, :any,
    default: :hover,
    values: [:always, :hover, :none, "always", "hover", "none"],
    doc: "Underline behavior (atom or string)"

  attr :weight, :any,
    default: :medium,
    values: [:normal, :medium, :semibold, :bold, "normal", "medium", "semibold", "bold"],
    doc: "Font weight (atom or string)"

  attr :external, :boolean, default: false, doc: "Open in new tab (href only)"
  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global, include: ~w(download hreflang ping referrerpolicy rel type method csrf_token)

  slot :inner_block, required: true, doc: "Link content"

  def styled_link(%{navigate: nav} = assigns) when not is_nil(nav) do
    ~H"""
    <.link
      navigate={@navigate}
      class={link_classes(@variant, @underline, @weight, @class)}
      {@rest}
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end

  def styled_link(%{patch: patch} = assigns) when not is_nil(patch) do
    ~H"""
    <.link
      patch={@patch}
      class={link_classes(@variant, @underline, @weight, @class)}
      {@rest}
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end

  def styled_link(assigns) do
    ~H"""
    <.link
      href={@href}
      target={@external && "_blank"}
      rel={@external && "noopener noreferrer"}
      class={link_classes(@variant, @underline, @weight, @class)}
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
    </.link>
    """
  end

  defp link_classes(variant, underline, weight, extra_class) do
    [
      link_variant_class(variant),
      underline_class(underline),
      weight_class(weight),
      "transition-colors",
      extra_class
    ]
  end

  @doc """
  Renders a navigation link with active state support.

  Supports LiveView navigation via `navigate` and `patch` attributes.

  ## Attributes

    * `:href` - Link destination URL for traditional navigation.
    * `:navigate` - LiveView navigate path.
    * `:patch` - LiveView patch path.
    * `:active` - Whether link represents current page.
    * `:class` - Additional CSS classes.

  One of `href`, `navigate`, or `patch` must be provided.

  ## Examples

      <.nav_link href="/" active={@current_path == "/"}>Home</.nav_link>
      <.nav_link navigate={~p"/dashboard"} active={@live_action == :dashboard}>Dashboard</.nav_link>
      <.nav_link patch={~p"/users?tab=settings"} active={@tab == :settings}>Settings</.nav_link>
  """
  @spec nav_link(map()) :: Phoenix.LiveView.Rendered.t()

  attr :href, :string, default: nil, doc: "Link destination URL"
  attr :navigate, :string, default: nil, doc: "LiveView navigate path"
  attr :patch, :string, default: nil, doc: "LiveView patch path"
  attr :active, :boolean, default: false, doc: "Active state"
  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global

  slot :inner_block, required: true, doc: "Link content"

  def nav_link(%{navigate: nav} = assigns) when not is_nil(nav) do
    ~H"""
    <.link
      navigate={@navigate}
      class={nav_link_classes(@active, @class)}
      aria-current={@active && "page"}
      {@rest}
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end

  def nav_link(%{patch: patch} = assigns) when not is_nil(patch) do
    ~H"""
    <.link
      patch={@patch}
      class={nav_link_classes(@active, @class)}
      aria-current={@active && "page"}
      {@rest}
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end

  def nav_link(assigns) do
    ~H"""
    <.link
      href={@href}
      class={nav_link_classes(@active, @class)}
      aria-current={@active && "page"}
      {@rest}
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end

  defp nav_link_classes(active, extra_class) do
    [
      "font-medium transition-colors",
      active && "text-primary",
      !active && "text-base-content/70 hover:text-base-content",
      extra_class
    ]
  end

  @doc """
  Renders a button-styled link with LiveView navigation support.

  ## Attributes

    * `:href` - Link destination URL for traditional navigation.
    * `:navigate` - LiveView navigate path.
    * `:patch` - LiveView patch path.
    * `:variant` - Button variant. Options: `:primary`, `:secondary`, `:accent`, `:ghost`, `:outline`.
    * `:size` - Button size. Options: `:xs`, `:sm`, `:md`, `:lg`.
    * `:external` - Open in new tab (href only). Defaults to false.
    * `:class` - Additional CSS classes.

  One of `href`, `navigate`, or `patch` must be provided.

  ## Examples

      <.button_link href="/signup" variant={:primary}>Sign Up</.button_link>
      <.button_link navigate={~p"/dashboard"} variant={:primary}>Go to Dashboard</.button_link>
      <.button_link patch={~p"/settings"} variant={:ghost}>Settings</.button_link>
      <.button_link href="/learn" variant={:ghost}>Learn More</.button_link>
  """
  @spec button_link(map()) :: Phoenix.LiveView.Rendered.t()

  attr :href, :string, default: nil, doc: "Link destination URL"
  attr :navigate, :string, default: nil, doc: "LiveView navigate path"
  attr :patch, :string, default: nil, doc: "LiveView patch path"

  attr :variant, :any,
    default: :primary,
    values: [
      :primary, :secondary, :accent, :ghost, :link, :outline,
      :neutral, :info, :success, :warning, :error,
      "primary", "secondary", "accent", "ghost", "link", "outline",
      "neutral", "info", "success", "warning", "error"
    ],
    doc: "Button variant (atom or string)"

  attr :size, :any,
    default: :md,
    values: [:xs, :sm, :md, :lg, "xs", "sm", "md", "lg"],
    doc: "Button size (atom or string)"

  attr :external, :boolean, default: false, doc: "Open in new tab (href only)"
  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :rest, :global

  slot :inner_block, required: true, doc: "Link content"

  def button_link(%{navigate: nav} = assigns) when not is_nil(nav) do
    ~H"""
    <.link
      navigate={@navigate}
      class={button_link_classes(@variant, @size, @class)}
      {@rest}
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end

  def button_link(%{patch: patch} = assigns) when not is_nil(patch) do
    ~H"""
    <.link
      patch={@patch}
      class={button_link_classes(@variant, @size, @class)}
      {@rest}
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end

  def button_link(assigns) do
    ~H"""
    <.link
      href={@href}
      target={@external && "_blank"}
      rel={@external && "noopener noreferrer"}
      class={button_link_classes(@variant, @size, @class)}
      {@rest}
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end

  defp button_link_classes(variant, size, extra_class) do
    ["btn", variant_class(variant), size_class(size), extra_class]
  end

  # Normalize string values to atoms
  defp to_atom(value) when is_atom(value), do: value
  defp to_atom(value) when is_binary(value), do: String.to_existing_atom(value)

  # Link variant classes (text colors for styled links)
  defp link_variant_class(variant) do
    case to_atom(variant) do
      :default -> "text-base-content"
      :primary -> "text-primary hover:text-primary-focus"
      :secondary -> "text-secondary hover:text-secondary-focus"
      :accent -> "text-accent hover:text-accent-focus"
      :muted -> "text-base-content/60 hover:text-base-content"
      :neutral -> "text-neutral hover:text-neutral-focus"
    end
  end

  # Underline classes
  defp underline_class(underline) do
    case to_atom(underline) do
      :always -> "underline"
      :hover -> "hover:underline"
      :none -> "no-underline"
    end
  end

  # Weight classes
  defp weight_class(weight) do
    case to_atom(weight) do
      :normal -> "font-normal"
      :medium -> "font-medium"
      :semibold -> "font-semibold"
      :bold -> "font-bold"
    end
  end

  # Button variant classes
  @variant_classes %{
    primary: "btn-primary",
    secondary: "btn-secondary",
    accent: "btn-accent",
    ghost: "btn-ghost",
    link: "btn-link",
    outline: "btn-outline",
    neutral: "btn-neutral",
    info: "btn-info",
    success: "btn-success",
    warning: "btn-warning",
    error: "btn-error"
  }

  defp variant_class(variant), do: Map.fetch!(@variant_classes, to_atom(variant))

  # Button size classes
  defp size_class(size) do
    case to_atom(size) do
      :xs -> "btn-xs"
      :sm -> "btn-sm"
      :md -> nil
      :lg -> "btn-lg"
    end
  end
end
