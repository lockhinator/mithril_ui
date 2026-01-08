defmodule MithrilUI.Components.Dropdown do
  @moduledoc """
  A dropdown menu component with LiveView.JS animations for smooth transitions.

  Supports various positions, triggers, and content types for flexible menu implementations.

  ## Examples

  Basic dropdown:

      <.dropdown>
        <:trigger>
          <button class="btn">Open Menu</button>
        </:trigger>
        <:item>Profile</:item>
        <:item>Settings</:item>
        <:item>Logout</:item>
      </.dropdown>

  With custom positioning:

      <.dropdown position="end">
        <:trigger>
          <button class="btn btn-primary">Actions</button>
        </:trigger>
        <:item phx-click="edit">Edit</:item>
        <:item phx-click="delete" class="text-error">Delete</:item>
      </.dropdown>

  With dividers and custom content:

      <.dropdown>
        <:trigger>Menu</:trigger>
        <:item>Item 1</:item>
        <:divider />
        <:item>Item 2</:item>
        <:content>
          <div class="p-4">Custom content here</div>
        </:content>
      </.dropdown>

  ## DaisyUI Classes

  The component uses the following DaisyUI classes:
  - `dropdown` - Base container
  - `dropdown-content` - Menu container
  - `dropdown-end` - Align to end
  - `dropdown-top` - Open upward
  - `dropdown-bottom` - Open downward (default)
  - `dropdown-left` - Open to left
  - `dropdown-right` - Open to right
  - `dropdown-hover` - Open on hover
  - `dropdown-open` - Force open state
  - `menu` - Menu styling for items

  ## Accessibility

  - Uses proper ARIA attributes for menu patterns
  - Supports keyboard navigation
  - Focus management with LiveView.JS
  """

  use Phoenix.Component
  alias Phoenix.LiveView.JS
  import MithrilUI.Animations

  @positions ~w(end top bottom left right)

  @doc """
  Renders a dropdown menu with trigger and menu items.

  ## Attributes

    * `:id` - Required. Unique identifier for the dropdown.
    * `:position` - Menu position relative to trigger.
      Supported: #{Enum.join(@positions, ", ")}.
    * `:hover` - Whether to open on hover instead of click. Defaults to false.
    * `:open` - Whether dropdown is forcibly open. Defaults to false.
    * `:class` - Additional CSS classes for the container.
    * `:menu_class` - Additional CSS classes for the menu.

  ## Slots

    * `:trigger` - The element that triggers the dropdown (required).
    * `:item` - Menu items with optional click handlers.
      - `:disabled` - Whether item is disabled.
      - `:class` - Additional classes for the item.
    * `:divider` - Visual separator between items.
    * `:content` - Custom content block (alternative to items).

  ## Examples

      <.dropdown id="user-menu" position="end">
        <:trigger>
          <button class="btn btn-ghost btn-circle avatar">
            <img src="/avatar.png" alt="User" />
          </button>
        </:trigger>
        <:item navigate="/profile">Profile</:item>
        <:item navigate="/settings">Settings</:item>
        <:divider />
        <:item phx-click="logout">Logout</:item>
      </.dropdown>
  """
  @spec dropdown(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, required: true
  attr :position, :string, default: nil, values: @positions ++ [nil]
  attr :hover, :boolean, default: false
  attr :open, :boolean, default: false
  attr :class, :string, default: nil
  attr :menu_class, :string, default: nil

  slot :trigger, required: true

  slot :item do
    attr :disabled, :boolean
    attr :class, :string
    attr :"phx-click", :any
    attr :"phx-target", :any
    attr :"phx-value-item", :any
    attr :"phx-value-id", :any
    attr :navigate, :string
    attr :patch, :string
    attr :href, :string
  end

  slot :divider

  slot :content

  def dropdown(assigns) do
    ~H"""
    <div class={dropdown_classes(@position, @hover, @open, @class)}>
      <div tabindex="0" role="button" class="m-1" aria-haspopup="true" aria-expanded={@open}>
        {render_slot(@trigger)}
      </div>
      <ul
        tabindex="0"
        class={menu_classes(@menu_class)}
        role="menu"
      >
        {render_items(@item, @divider, @content)}
      </ul>
    </div>
    """
  end

  defp render_items(items, dividers, content) do
    assigns = %{items: items, dividers: dividers, content: content}

    ~H"""
    <%= for item <- @items do %>
      <li role="none">
        <a
          role="menuitem"
          class={item_classes(item[:disabled], item[:class])}
          tabindex={if item[:disabled], do: "-1", else: "0"}
          aria-disabled={item[:disabled]}
          {assigns_to_attributes(item, [:disabled, :class, :inner_block])}
        >
          {render_slot(item)}
        </a>
      </li>
    <% end %>
    <%= for _divider <- @dividers do %>
      <li class="divider" role="separator"></li>
    <% end %>
    <%= for block <- @content do %>
      <li role="none">
        {render_slot(block)}
      </li>
    <% end %>
    """
  end

  @doc """
  Renders an animated dropdown that uses LiveView.JS for show/hide transitions.

  This variant provides smoother animations compared to CSS-only dropdowns.

  ## Attributes

  Same as `dropdown/1` plus:
    * `:js_show` - Custom JS command for showing. Defaults to fade animation.
    * `:js_hide` - Custom JS command for hiding. Defaults to fade animation.

  ## Examples

      <.animated_dropdown id="actions-menu">
        <:trigger>
          <button class="btn">Actions</button>
        </:trigger>
        <:item phx-click="action1">Action 1</:item>
        <:item phx-click="action2">Action 2</:item>
      </.animated_dropdown>
  """
  @spec animated_dropdown(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, required: true
  attr :position, :string, default: nil, values: @positions ++ [nil]
  attr :class, :string, default: nil
  attr :menu_class, :string, default: nil

  slot :trigger, required: true

  slot :item do
    attr :disabled, :boolean
    attr :class, :string
    attr :"phx-click", :any
    attr :"phx-target", :any
    attr :"phx-value-item", :any
    attr :"phx-value-id", :any
    attr :navigate, :string
    attr :patch, :string
    attr :href, :string
  end

  slot :divider

  slot :content

  def animated_dropdown(assigns) do
    ~H"""
    <div class={["dropdown", position_class(@position), @class]} id={@id}>
      <div
        tabindex="0"
        role="button"
        class="m-1"
        aria-haspopup="true"
        aria-controls={"#{@id}-menu"}
        phx-click={toggle_dropdown(@id)}
      >
        {render_slot(@trigger)}
      </div>
      <ul
        id={"#{@id}-menu"}
        tabindex="0"
        class={["hidden", menu_classes(@menu_class)]}
        role="menu"
        phx-click-away={hide_dropdown(@id)}
      >
        {render_items(@item, @divider, @content)}
      </ul>
    </div>
    """
  end

  @doc """
  Shows the dropdown menu.

  ## Examples

      <button phx-click={MithrilUI.Components.Dropdown.show_dropdown("my-dropdown")}>
        Show Menu
      </button>
  """
  @spec show_dropdown(String.t()) :: Phoenix.LiveView.JS.t()
  def show_dropdown(id) do
    JS.show(
      to: "##{id}-menu",
      transition: dropdown_enter()
    )
    |> JS.set_attribute({"aria-expanded", "true"}, to: "##{id} [role=button]")
  end

  @doc """
  Hides the dropdown menu.

  ## Examples

      <button phx-click={MithrilUI.Components.Dropdown.hide_dropdown("my-dropdown")}>
        Close Menu
      </button>
  """
  @spec hide_dropdown(String.t()) :: Phoenix.LiveView.JS.t()
  def hide_dropdown(id) do
    JS.hide(
      to: "##{id}-menu",
      transition: dropdown_leave()
    )
    |> JS.set_attribute({"aria-expanded", "false"}, to: "##{id} [role=button]")
  end

  @doc """
  Toggles the dropdown menu visibility.
  """
  @spec toggle_dropdown(String.t()) :: Phoenix.LiveView.JS.t()
  def toggle_dropdown(id) do
    JS.toggle(
      to: "##{id}-menu",
      in: dropdown_enter(),
      out: dropdown_leave()
    )
    |> JS.toggle_attribute({"aria-expanded", "true", "false"}, to: "##{id} [role=button]")
  end

  defp dropdown_classes(position, hover, open, extra_class) do
    [
      "dropdown",
      position_class(position),
      hover && "dropdown-hover",
      open && "dropdown-open",
      extra_class
    ]
  end

  defp position_class(nil), do: nil
  defp position_class("end"), do: "dropdown-end"
  defp position_class("top"), do: "dropdown-top"
  defp position_class("bottom"), do: "dropdown-bottom"
  defp position_class("left"), do: "dropdown-left"
  defp position_class("right"), do: "dropdown-right"

  defp menu_classes(extra_class) do
    [
      "dropdown-content menu bg-base-100 rounded-box z-10 w-52 p-2 shadow-lg",
      extra_class
    ]
  end

  defp item_classes(disabled, extra_class) do
    [
      disabled && "disabled",
      extra_class
    ]
  end
end
