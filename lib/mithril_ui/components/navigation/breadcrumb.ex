defmodule MithrilUI.Components.Breadcrumb do
  @moduledoc """
  A breadcrumb navigation component for showing hierarchical page structure.

  Breadcrumbs help users understand their location within a site's hierarchy
  and navigate back to parent pages.

  ## Examples

  Basic breadcrumb:

      <.breadcrumb>
        <:item href="/">Home</:item>
        <:item href="/products">Products</:item>
        <:item>Current Page</:item>
      </.breadcrumb>

  With icons:

      <.breadcrumb>
        <:item href="/" icon="home">Home</:item>
        <:item href="/docs" icon="document">Documentation</:item>
        <:item>Getting Started</:item>
      </.breadcrumb>

  ## DaisyUI Classes

  The component uses the following DaisyUI classes:
  - `breadcrumbs` - Base container with built-in separators
  """

  use Phoenix.Component

  @doc """
  Renders a breadcrumb navigation trail.

  ## Attributes

    * `:class` - Additional CSS classes for the container.
    * `:size` - Text size: sm, base, lg. Defaults to "sm".
    * `:max_width` - Max width class for overflow scrolling. Defaults to nil.

  ## Slots

    * `:item` - Breadcrumb items.
      - `:navigate` - LiveView navigation path.
      - `:patch` - LiveView patch path.
      - `:href` - Standard link href.
      - `:icon` - Icon content to display before text.

  ## Examples

      <.breadcrumb>
        <:item navigate="/">Home</:item>
        <:item navigate="/users">Users</:item>
        <:item>Profile</:item>
      </.breadcrumb>
  """
  @spec breadcrumb(map()) :: Phoenix.LiveView.Rendered.t()

  attr :class, :string, default: nil
  attr :size, :string, default: "sm", values: ~w(xs sm base lg)
  attr :max_width, :string, default: nil

  attr :rest, :global

  slot :item, required: true do
    attr :navigate, :string
    attr :patch, :string
    attr :href, :string
    attr :icon, :string
  end

  def breadcrumb(assigns) do
    ~H"""
    <div class={breadcrumb_classes(@size, @max_width, @class)} {@rest}>
      <ul>
        <li :for={item <- @item}>
          <%= if has_link?(item) do %>
            <a {item_link_attrs(item)} class="inline-flex items-center gap-2">
              <span :if={item[:icon]} class="h-4 w-4">{item[:icon]}</span>
              {render_slot(item)}
            </a>
          <% else %>
            <span class="inline-flex items-center gap-2">
              <span :if={item[:icon]} class="h-4 w-4">{item[:icon]}</span>
              {render_slot(item)}
            </span>
          <% end %>
        </li>
      </ul>
    </div>
    """
  end

  @doc """
  Renders a breadcrumb from a list of path segments.

  Automatically generates href paths based on segment accumulation.

  ## Attributes

    * `:segments` - List of path segment names (required).
    * `:base_path` - Base path to prepend. Defaults to "/".
    * `:home` - Whether to include home link. Defaults to true.
    * `:home_label` - Label for home link. Defaults to "Home".
    * `:class` - Additional CSS classes.

  ## Examples

      <.breadcrumb_from_segments segments={["products", "electronics", "phones"]} />

      <%!-- Generates: Home > Products > Electronics > Phones --%>
  """
  @spec breadcrumb_from_segments(map()) :: Phoenix.LiveView.Rendered.t()

  attr :segments, :list, required: true
  attr :base_path, :string, default: "/"
  attr :home, :boolean, default: true
  attr :home_label, :string, default: "Home"
  attr :class, :string, default: nil

  def breadcrumb_from_segments(assigns) do
    assigns = assign(assigns, :items, build_breadcrumb_items(assigns))

    ~H"""
    <div class={["breadcrumbs text-sm", @class]}>
      <ul>
        <li :if={@home}>
          <a href={@base_path}>{@home_label}</a>
        </li>
        <li :for={{label, path, is_last} <- @items}>
          <%= if is_last do %>
            <span>{label}</span>
          <% else %>
            <a href={path}>{label}</a>
          <% end %>
        </li>
      </ul>
    </div>
    """
  end

  defp build_breadcrumb_items(%{segments: segments, base_path: base_path}) do
    segments
    |> Enum.with_index()
    |> Enum.map(fn {segment, index} ->
      path = build_path(base_path, Enum.take(segments, index + 1))
      label = humanize_segment(segment)
      is_last = index == length(segments) - 1
      {label, path, is_last}
    end)
  end

  defp build_path(base, segments) do
    Path.join([base | segments])
  end

  defp humanize_segment(segment) when is_binary(segment) do
    segment
    |> String.replace(~r/[-_]/, " ")
    |> String.split()
    |> Enum.map_join(" ", &String.capitalize/1)
  end

  defp humanize_segment(segment), do: to_string(segment)

  defp breadcrumb_classes(size, max_width, extra_class) do
    [
      "breadcrumbs",
      size && "text-#{size}",
      max_width && "max-w-#{max_width} overflow-x-auto",
      extra_class
    ]
  end

  defp has_link?(item) do
    item[:navigate] || item[:patch] || item[:href]
  end

  defp item_link_attrs(item) do
    cond do
      item[:navigate] -> [navigate: item[:navigate]]
      item[:patch] -> [patch: item[:patch]]
      item[:href] -> [href: item[:href]]
      true -> []
    end
  end
end
