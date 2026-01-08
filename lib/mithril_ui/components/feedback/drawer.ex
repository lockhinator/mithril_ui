defmodule MithrilUI.Components.Drawer do
  @moduledoc """
  Slide-out drawer component for side panels and navigation.

  Drawers slide in from the edge of the screen and are typically used
  for navigation menus, settings panels, or supplementary content.

  ## Examples

  Basic drawer:

      <.drawer id="menu-drawer" side="left">
        <:trigger>
          <button class="btn">Open Menu</button>
        </:trigger>
        <nav>
          <a href="/">Home</a>
          <a href="/about">About</a>
        </nav>
      </.drawer>

  Drawer with explicit open control:

      <button phx-click={show_drawer("settings-drawer")}>Settings</button>
      <.drawer id="settings-drawer" side="right">
        <h2>Settings</h2>
        <!-- settings content -->
      </.drawer>

  ## DaisyUI Classes

  - `drawer` - Drawer container
  - `drawer-toggle` - Hidden checkbox for state
  - `drawer-content` - Main content area
  - `drawer-side` - Drawer panel
  - `drawer-overlay` - Background overlay
  """

  use Phoenix.Component
  alias Phoenix.LiveView.JS
  import MithrilUI.Animations

  @doc """
  Renders a drawer panel.

  ## Attributes

    * `:id` - Required. Unique identifier for the drawer.
    * `:side` - Which side drawer slides from: left, right. Defaults to "left".
    * `:open` - Whether drawer is initially open. Defaults to false.
    * `:overlay` - Whether to show backdrop overlay. Defaults to true.
    * `:class` - Additional CSS classes for drawer content.

  ## Slots

    * `:trigger` - Optional trigger element (placed in main content).
    * `:inner_block` - Drawer panel content (required).

  ## Examples

      <.drawer id="nav-drawer" side="left">
        <:trigger>
          <button class="btn btn-ghost lg:hidden">
            <svg><!-- hamburger icon --></svg>
          </button>
        </:trigger>
        <ul class="menu">
          <li><a href="/">Home</a></li>
          <li><a href="/dashboard">Dashboard</a></li>
        </ul>
      </.drawer>
  """
  @spec drawer(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, required: true
  attr :side, :string, default: "left", values: ~w(left right)
  attr :open, :boolean, default: false
  attr :overlay, :boolean, default: true
  attr :class, :any, default: nil

  slot :trigger
  slot :inner_block, required: true

  def drawer(assigns) do
    ~H"""
    <div class={drawer_classes(@side)}>
      <input
        id={"#{@id}-toggle"}
        type="checkbox"
        class="drawer-toggle"
        checked={@open}
        aria-label="Toggle drawer"
      />
      <div class="drawer-content">
        <label :if={@trigger != []} for={"#{@id}-toggle"} class="drawer-button">
          {render_slot(@trigger)}
        </label>
      </div>
      <div class="drawer-side z-50">
        <label
          :if={@overlay}
          for={"#{@id}-toggle"}
          aria-label="Close drawer"
          class="drawer-overlay"
        />
        <div
          id={@id}
          class={["min-h-full bg-base-200", @class]}
          role="dialog"
          aria-modal="true"
        >
          {render_slot(@inner_block)}
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Renders an animated drawer using LiveView.JS for transitions.

  This variant provides smooth slide animations.

  ## Attributes

  Same as `drawer/1`.

  ## Examples

      <.animated_drawer id="menu" side="left">
        <nav>Menu content</nav>
      </.animated_drawer>

      <button phx-click={show_drawer("menu")}>Open Menu</button>
  """
  @spec animated_drawer(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, required: true
  attr :side, :string, default: "left", values: ~w(left right)
  attr :overlay, :boolean, default: true
  attr :class, :any, default: nil

  slot :inner_block, required: true

  def animated_drawer(assigns) do
    side_atom = String.to_atom(assigns.side)

    assigns = assign(assigns, :side_atom, side_atom)

    ~H"""
    <div id={@id} class="relative z-50 hidden" aria-modal="true" role="dialog">
      <div
        :if={@overlay}
        id={"#{@id}-overlay"}
        class="fixed inset-0 bg-black/50"
        phx-click={hide_drawer(@id, @side_atom)}
      />
      <div class={["fixed inset-y-0 flex", @side == "left" && "left-0", @side == "right" && "right-0"]}>
        <div
          id={"#{@id}-panel"}
          class={["relative w-80 max-w-xs bg-base-200 p-4", @class]}
          phx-click-away={hide_drawer(@id, @side_atom)}
          phx-window-keydown={hide_drawer(@id, @side_atom)}
          phx-key="escape"
        >
          <button
            type="button"
            class="btn btn-sm btn-circle btn-ghost absolute right-2 top-2"
            aria-label="Close drawer"
            phx-click={hide_drawer(@id, @side_atom)}
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="h-5 w-5"
              viewBox="0 0 20 20"
              fill="currentColor"
            >
              <path
                fill-rule="evenodd"
                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                clip-rule="evenodd"
              />
            </svg>
          </button>
          <div class="mt-8">
            {render_slot(@inner_block)}
          </div>
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Shows a drawer with animation.
  """
  @spec show_drawer(String.t(), :left | :right) :: Phoenix.LiveView.JS.t()
  def show_drawer(id, side \\ :left) do
    JS.show(to: "##{id}")
    |> JS.show(to: "##{id}-overlay", transition: backdrop_enter())
    |> JS.show(to: "##{id}-panel", transition: drawer_enter(side))
    |> JS.focus_first(to: "##{id}-panel")
  end

  @doc """
  Hides a drawer with animation.
  """
  @spec hide_drawer(String.t(), :left | :right) :: Phoenix.LiveView.JS.t()
  def hide_drawer(id, side \\ :left) do
    JS.hide(to: "##{id}-overlay", transition: backdrop_leave())
    |> JS.hide(to: "##{id}-panel", transition: drawer_leave(side))
    |> JS.hide(to: "##{id}", transition: {"", "", ""})
    |> JS.pop_focus()
  end

  defp drawer_classes(side) do
    [
      "drawer",
      side == "right" && "drawer-end"
    ]
  end
end
