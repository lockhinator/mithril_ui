defmodule MithrilUI.Components.BottomNavigation do
  @moduledoc """
  A bottom navigation bar component for mobile-first navigation.

  Bottom navigation bars provide quick access to top-level views and are
  typically fixed at the bottom of the screen on mobile devices.

  ## Examples

  Basic bottom navigation:

      <.bottom_nav>
        <:item label="Home" active>
          <svg>...</svg>
        </:item>
        <:item label="Search">
          <svg>...</svg>
        </:item>
        <:item label="Profile">
          <svg>...</svg>
        </:item>
      </.bottom_nav>

  With event handlers:

      <.bottom_nav on_select="nav_changed">
        <:item label="Home" value="home" active>
          <.icon name="home" />
        </:item>
        <:item label="Messages" value="messages" badge="3">
          <.icon name="mail" />
        </:item>
      </.bottom_nav>

  ## DaisyUI Classes

  The component uses the following DaisyUI classes:
  - `dock` - Base container (bottom navigation)
  - `dock-label` - Label text
  - `dock-active` - Active item state
  - `dock-xs`, `dock-sm`, `dock-md`, `dock-lg`, `dock-xl` - Size variants
  """

  use Phoenix.Component

  @sizes ~w(xs sm md lg xl)

  @doc """
  Renders a bottom navigation bar.

  ## Attributes

    * `:class` - Additional CSS classes for the container.
    * `:size` - Size variant: xs, sm, md, lg, xl. Defaults to nil (default size).
    * `:fixed` - Whether the nav is fixed to bottom. Defaults to true.
    * `:on_select` - Event name triggered when an item is selected.

  ## Slots

    * `:item` - Navigation items.
      - `:label` - Text label for the item.
      - `:value` - Value sent with on_select event.
      - `:active` - Whether this item is active.
      - `:disabled` - Whether this item is disabled.
      - `:navigate` - LiveView navigation path.
      - `:href` - Standard link href.
      - `:badge` - Badge text to display.

  ## Examples

      <.bottom_nav size="sm">
        <:item label="Home" active navigate="/">
          <svg class="h-5 w-5">...</svg>
        </:item>
        <:item label="Search" navigate="/search">
          <svg class="h-5 w-5">...</svg>
        </:item>
        <:item label="Settings" navigate="/settings">
          <svg class="h-5 w-5">...</svg>
        </:item>
      </.bottom_nav>
  """
  @spec bottom_nav(map()) :: Phoenix.LiveView.Rendered.t()

  attr :class, :string, default: nil
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :fixed, :boolean, default: true
  attr :on_select, :string, default: nil

  attr :rest, :global

  slot :item, required: true do
    attr :label, :string
    attr :value, :any
    attr :active, :boolean
    attr :disabled, :boolean
    attr :navigate, :string
    attr :href, :string
    attr :badge, :string
  end

  def bottom_nav(assigns) do
    ~H"""
    <div class={dock_classes(@size, @fixed, @class)} {@rest}>
      <%= for item <- @item do %>
        <%= if item[:navigate] || item[:href] do %>
          <a
            class={item_classes(item[:active], item[:disabled])}
            {item_link_attrs(item)}
            aria-disabled={item[:disabled]}
          >
            <span class="relative">
              {render_slot(item)}
              <span
                :if={item[:badge]}
                class="absolute -top-1 -right-1 badge badge-xs badge-primary"
              >
                {item[:badge]}
              </span>
            </span>
            <span :if={item[:label]} class="dock-label">{item[:label]}</span>
          </a>
        <% else %>
          <button
            type="button"
            class={item_classes(item[:active], item[:disabled])}
            disabled={item[:disabled]}
            phx-click={@on_select}
            phx-value-item={item[:value]}
          >
            <span class="relative">
              {render_slot(item)}
              <span
                :if={item[:badge]}
                class="absolute -top-1 -right-1 badge badge-xs badge-primary"
              >
                {item[:badge]}
              </span>
            </span>
            <span :if={item[:label]} class="dock-label">{item[:label]}</span>
          </button>
        <% end %>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a simple bottom navigation with icons only (no labels).

  ## Attributes

    * `:class` - Additional CSS classes.
    * `:size` - Size variant: xs, sm, md, lg, xl.
    * `:fixed` - Whether the nav is fixed to bottom. Defaults to true.
    * `:on_select` - Event name triggered when an item is selected.

  ## Slots

    * `:item` - Navigation items containing icon content.
      - `:value` - Value sent with on_select event.
      - `:active` - Whether this item is active.
      - `:aria_label` - Accessible label for the item.

  ## Examples

      <.icon_bottom_nav on_select="nav_changed">
        <:item value="home" active aria_label="Home">
          <svg class="h-6 w-6">...</svg>
        </:item>
        <:item value="search" aria_label="Search">
          <svg class="h-6 w-6">...</svg>
        </:item>
      </.icon_bottom_nav>
  """
  @spec icon_bottom_nav(map()) :: Phoenix.LiveView.Rendered.t()

  attr :class, :string, default: nil
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :fixed, :boolean, default: true
  attr :on_select, :string, default: nil

  attr :rest, :global

  slot :item, required: true do
    attr :value, :any
    attr :active, :boolean
    attr :aria_label, :string
  end

  def icon_bottom_nav(assigns) do
    ~H"""
    <div class={dock_classes(@size, @fixed, @class)} {@rest}>
      <button
        :for={item <- @item}
        type="button"
        class={item_classes(item[:active], false)}
        phx-click={@on_select}
        phx-value-item={item[:value]}
        aria-label={item[:aria_label]}
      >
        {render_slot(item)}
      </button>
    </div>
    """
  end

  @doc """
  Renders a bottom navigation styled as an application bar with a center action button.

  ## Attributes

    * `:class` - Additional CSS classes.
    * `:on_select` - Event name triggered when an item is selected.
    * `:on_action` - Event name triggered when center action is clicked.

  ## Slots

    * `:item` - Navigation items (typically 4, split around center action).
    * `:action` - Center action button content.

  ## Examples

      <.app_bar on_select="nav" on_action="create">
        <:item value="home" label="Home" active>
          <svg>...</svg>
        </:item>
        <:item value="search" label="Search">
          <svg>...</svg>
        </:item>
        <:action>
          <svg class="h-6 w-6">...</svg>
        </:action>
        <:item value="notifications" label="Alerts">
          <svg>...</svg>
        </:item>
        <:item value="profile" label="Profile">
          <svg>...</svg>
        </:item>
      </.app_bar>
  """
  @spec app_bar(map()) :: Phoenix.LiveView.Rendered.t()

  attr :class, :string, default: nil
  attr :on_select, :string, default: nil
  attr :on_action, :string, default: nil

  attr :rest, :global

  slot :item do
    attr :label, :string
    attr :value, :any
    attr :active, :boolean
  end

  slot :action

  def app_bar(assigns) do
    # Split items in half for center action placement
    items = assigns.item
    mid = div(length(items), 2)
    {left_items, right_items} = Enum.split(items, mid)
    assigns = assign(assigns, left_items: left_items, right_items: right_items)

    ~H"""
    <div
      class={[
        "fixed bottom-0 left-0 z-50 w-full h-16 bg-base-100 border-t border-base-200",
        @class
      ]}
      {@rest}
    >
      <div class="grid h-full max-w-lg grid-cols-5 mx-auto">
        <%= for item <- @left_items do %>
          <button
            type="button"
            class={app_bar_item_classes(item[:active])}
            phx-click={@on_select}
            phx-value-item={item[:value]}
          >
            {render_slot(item)}
            <span :if={item[:label]} class="text-xs">{item[:label]}</span>
          </button>
        <% end %>

        <div class="flex items-center justify-center">
          <button
            :if={@action != []}
            type="button"
            class="btn btn-primary btn-circle -mt-6 shadow-lg"
            phx-click={@on_action}
          >
            {render_slot(@action)}
          </button>
        </div>

        <%= for item <- @right_items do %>
          <button
            type="button"
            class={app_bar_item_classes(item[:active])}
            phx-click={@on_select}
            phx-value-item={item[:value]}
          >
            {render_slot(item)}
            <span :if={item[:label]} class="text-xs">{item[:label]}</span>
          </button>
        <% end %>
      </div>
    </div>
    """
  end

  defp dock_classes(size, fixed, extra_class) do
    [
      "dock",
      size && "dock-#{size}",
      fixed && "fixed bottom-0 left-0 z-50 w-full",
      extra_class
    ]
  end

  defp item_classes(active, disabled) do
    [
      active && "dock-active",
      disabled && "opacity-50 cursor-not-allowed"
    ]
  end

  defp app_bar_item_classes(active) do
    [
      "inline-flex flex-col items-center justify-center px-5 hover:bg-base-200 group",
      active && "text-primary"
    ]
  end

  defp item_link_attrs(item) do
    cond do
      item[:navigate] -> [navigate: item[:navigate]]
      item[:href] -> [href: item[:href]]
      true -> []
    end
  end
end
