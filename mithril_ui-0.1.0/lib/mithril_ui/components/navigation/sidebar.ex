defmodule MithrilUI.Components.Sidebar do
  @moduledoc """
  A sidebar navigation component with support for menu items, submenus, and collapsible sections.

  The sidebar uses DaisyUI's menu component for styling and supports various
  features like icons, badges, dividers, and nested dropdown menus.

  ## Examples

  Basic sidebar:

      <.sidebar>
        <:item icon="home" navigate="/dashboard">Dashboard</:item>
        <:item icon="users" navigate="/users">Users</:item>
        <:item icon="settings" navigate="/settings">Settings</:item>
      </.sidebar>

  With title and dividers:

      <.sidebar>
        <:title>Main Menu</:title>
        <:item navigate="/dashboard">Dashboard</:item>
        <:item navigate="/analytics">Analytics</:item>
        <:divider />
        <:title>Settings</:title>
        <:item navigate="/profile">Profile</:item>
        <:item navigate="/account">Account</:item>
      </.sidebar>

  ## DaisyUI Classes

  The component uses the following DaisyUI classes:
  - `menu` - Base menu container
  - `menu-title` - Section heading
  - `menu-lg`, `menu-md`, `menu-sm`, `menu-xs` - Size variants
  """

  use Phoenix.Component

  @sizes ~w(xs sm md lg xl)

  @doc """
  Renders a sidebar navigation menu.

  ## Attributes

    * `:class` - Additional CSS classes for the sidebar container.
    * `:size` - Menu size: xs, sm, md, lg, xl. Defaults to nil (default size).
    * `:rounded` - Whether menu items have rounded corners. Defaults to true.
    * `:width` - Width class for the sidebar. Defaults to "w-64".

  ## Slots

    * `:title` - Section titles/headings.
    * `:item` - Menu items with navigation support.
      - `:navigate` - LiveView navigation path.
      - `:patch` - LiveView patch path.
      - `:href` - Standard link href.
      - `:active` - Whether this item is currently active.
      - `:disabled` - Whether this item is disabled.
      - `:icon` - Icon name to display (optional).
      - `:badge` - Badge text to display (optional).
      - `:badge_variant` - Badge variant: primary, secondary, accent, etc.
    * `:divider` - Visual separator between sections.
    * `:submenu` - Collapsible submenu section.
      - `:label` - The submenu trigger label.
      - `:open` - Whether submenu is open by default.

  ## Examples

      <.sidebar size="lg">
        <:title>Navigation</:title>
        <:item navigate="/" active>Home</:item>
        <:item navigate="/about">About</:item>
        <:item navigate="/contact" badge="New" badge_variant="primary">Contact</:item>
        <:divider />
        <:submenu label="Settings">
          <:item navigate="/settings/profile">Profile</:item>
          <:item navigate="/settings/account">Account</:item>
        </:submenu>
      </.sidebar>
  """
  @spec sidebar(map()) :: Phoenix.LiveView.Rendered.t()

  attr :class, :string, default: nil
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :rounded, :boolean, default: true
  attr :width, :string, default: "w-64"

  attr :rest, :global

  slot :title

  slot :item do
    attr :navigate, :string
    attr :patch, :string
    attr :href, :string
    attr :active, :boolean
    attr :disabled, :boolean
    attr :icon, :string
    attr :badge, :string
    attr :badge_variant, :string
    attr :class, :string
  end

  slot :divider

  slot :submenu do
    attr :label, :string
    attr :open, :boolean
  end

  def sidebar(assigns) do
    ~H"""
    <aside class={[@width, @class]} {@rest}>
      <ul class={menu_classes(@size, @rounded)}>
        {render_menu_content(assigns)}
      </ul>
    </aside>
    """
  end

  defp render_menu_content(assigns) do
    ~H"""
    <%= for title <- @title do %>
      <li class="menu-title">{render_slot(title)}</li>
    <% end %>
    <%= for item <- @item do %>
      <li>
        <a
          class={item_classes(item[:active], item[:disabled], item[:class])}
          {item_link_attrs(item)}
          aria-disabled={item[:disabled]}
        >
          {render_slot(item)}
          <span :if={item[:badge]} class={badge_classes(item[:badge_variant])}>
            {item[:badge]}
          </span>
        </a>
      </li>
    <% end %>
    <%= for _divider <- @divider do %>
      <li class="my-2 border-t border-base-200"></li>
    <% end %>
    <%= for submenu <- @submenu do %>
      <li>
        <details open={submenu[:open]}>
          <summary>{submenu[:label] || "Menu"}</summary>
          <ul>
            {render_slot(submenu)}
          </ul>
        </details>
      </li>
    <% end %>
    """
  end

  @doc """
  Renders a simple menu list without the sidebar wrapper.

  Useful for embedding menus inside other containers like drawers or dropdowns.

  ## Attributes

    * `:class` - Additional CSS classes.
    * `:size` - Menu size: xs, sm, md, lg, xl.
    * `:horizontal` - Whether menu is horizontal. Defaults to false.

  ## Slots

    * `:item` - Menu items.

  ## Examples

      <.menu horizontal>
        <:item href="/">Home</:item>
        <:item href="/about">About</:item>
        <:item href="/contact">Contact</:item>
      </.menu>
  """
  @spec menu(map()) :: Phoenix.LiveView.Rendered.t()

  attr :class, :string, default: nil
  attr :size, :string, default: nil, values: @sizes ++ [nil]
  attr :horizontal, :boolean, default: false

  slot :item do
    attr :navigate, :string
    attr :patch, :string
    attr :href, :string
    attr :active, :boolean
    attr :disabled, :boolean
    attr :class, :string
  end

  def menu(assigns) do
    ~H"""
    <ul class={[
      "menu",
      @size && "menu-#{@size}",
      @horizontal && "menu-horizontal",
      !@horizontal && "menu-vertical",
      @class
    ]}>
      <li :for={item <- @item}>
        <a
          class={item_classes(item[:active], item[:disabled], item[:class])}
          {item_link_attrs(item)}
        >
          {render_slot(item)}
        </a>
      </li>
    </ul>
    """
  end

  @doc """
  Renders a menu item for use inside submenu slots.

  ## Attributes

    * `:navigate` - LiveView navigation path.
    * `:patch` - LiveView patch path.
    * `:href` - Standard link href.
    * `:active` - Whether item is active.
    * `:disabled` - Whether item is disabled.

  ## Examples

      <.submenu_item navigate="/settings/profile">Profile</.submenu_item>
  """
  @spec submenu_item(map()) :: Phoenix.LiveView.Rendered.t()

  attr :navigate, :string, default: nil
  attr :patch, :string, default: nil
  attr :href, :string, default: nil
  attr :active, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :class, :string, default: nil

  slot :inner_block, required: true

  def submenu_item(assigns) do
    ~H"""
    <li>
      <a
        class={item_classes(@active, @disabled, @class)}
        {item_link_attrs(assigns)}
        aria-disabled={@disabled}
      >
        {render_slot(@inner_block)}
      </a>
    </li>
    """
  end

  defp menu_classes(size, rounded) do
    [
      "menu bg-base-200 rounded-box",
      size && "menu-#{size}",
      rounded && "rounded-lg"
    ]
  end

  defp item_classes(active, disabled, extra_class) do
    [
      active && "active",
      disabled && "disabled",
      extra_class
    ]
  end

  defp badge_classes(nil), do: "badge badge-sm"
  defp badge_classes(variant), do: "badge badge-sm badge-#{variant}"

  defp item_link_attrs(item) do
    cond do
      item[:navigate] -> [navigate: item[:navigate]]
      item[:patch] -> [patch: item[:patch]]
      item[:href] -> [href: item[:href]]
      true -> []
    end
  end
end
