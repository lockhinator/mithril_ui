defmodule MithrilUI.Components.ListGroup do
  @moduledoc """
  List group component for displaying lists of related items.

  ## Examples

  Basic list:

      <.list_group>
        <:item>Item 1</:item>
        <:item>Item 2</:item>
        <:item>Item 3</:item>
      </.list_group>

  With links:

      <.list_group>
        <:item href="/profile">Profile</:item>
        <:item href="/settings">Settings</:item>
      </.list_group>

  ## DaisyUI Classes

  - `menu` - Base menu/list styling
  - `menu-horizontal` - Horizontal layout
  - `menu-vertical` - Vertical layout (default)
  """

  use Phoenix.Component

  @doc """
  Renders a list group.

  ## Attributes

    * `:bordered` - Add border around list. Defaults to true.
    * `:rounded` - Add rounded corners. Defaults to true.
    * `:horizontal` - Horizontal layout. Defaults to false.
    * `:compact` - Compact item spacing. Defaults to false.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:item` - List items.
      - `:active` - Whether item is active.
      - `:disabled` - Whether item is disabled.
      - `:href` - Link URL.
      - `:navigate` - LiveView navigate path.
      - `:class` - Additional item classes.

  ## Examples

      <.list_group bordered>
        <:item active>Selected Item</:item>
        <:item>Regular Item</:item>
        <:item disabled>Disabled Item</:item>
      </.list_group>
  """
  @spec list_group(map()) :: Phoenix.LiveView.Rendered.t()

  attr :bordered, :boolean, default: true
  attr :rounded, :boolean, default: true
  attr :horizontal, :boolean, default: false
  attr :compact, :boolean, default: false
  attr :class, :any, default: nil

  slot :item do
    attr :active, :boolean
    attr :disabled, :boolean
    attr :href, :string
    attr :navigate, :string
    attr :class, :any
  end

  slot :title

  def list_group(assigns) do
    ~H"""
    <ul class={list_classes(@bordered, @rounded, @horizontal, @compact, @class)}>
      <li :if={@title != []}>
        <h2 class="menu-title">{render_slot(@title)}</h2>
      </li>
      <li :for={item <- @item}>
        <%= if item[:href] || item[:navigate] do %>
          <.link
            href={item[:href]}
            navigate={item[:navigate]}
            class={item_classes(item[:active], item[:disabled], item[:class])}
          >
            {render_slot(item)}
          </.link>
        <% else %>
          <a class={item_classes(item[:active], item[:disabled], item[:class])}>
            {render_slot(item)}
          </a>
        <% end %>
      </li>
    </ul>
    """
  end

  @doc """
  Renders a simple list with items from a list.

  ## Attributes

    * `:items` - List of items to display.
    * `:item_class` - Class applied to each item.

  ## Examples

      <.simple_list items={["Apple", "Banana", "Cherry"]} />
  """
  @spec simple_list(map()) :: Phoenix.LiveView.Rendered.t()

  attr :items, :list, required: true
  attr :bordered, :boolean, default: true
  attr :rounded, :boolean, default: true
  attr :item_class, :string, default: nil
  attr :class, :any, default: nil

  def simple_list(assigns) do
    ~H"""
    <ul class={list_classes(@bordered, @rounded, false, false, @class)}>
      <li :for={item <- @items}>
        <a class={@item_class}>{item}</a>
      </li>
    </ul>
    """
  end

  defp list_classes(bordered, rounded, horizontal, compact, extra_class) do
    [
      "menu bg-base-200",
      bordered && "border border-base-300",
      rounded && "rounded-box",
      horizontal && "menu-horizontal",
      !horizontal && "menu-vertical",
      compact && "menu-compact",
      extra_class
    ]
  end

  defp item_classes(active, disabled, extra_class) do
    [
      active && "active",
      disabled && "disabled",
      extra_class
    ]
  end
end
