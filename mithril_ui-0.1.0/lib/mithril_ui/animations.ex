defmodule MithrilUI.Animations do
  @moduledoc """
  Predefined animation presets for use with Phoenix.LiveView.JS commands.

  These animations work with Tailwind CSS transition utilities and are designed
  to be used with `JS.show/2` and `JS.hide/2` transition options.

  ## Usage

      import MithrilUI.Animations

      JS.show(transition: modal_enter())
      JS.hide(transition: modal_leave())

  ## Animation Types

  - **Modal** - Scale + fade for dialog overlays
  - **Dropdown** - Fade + slide for menus
  - **Toast** - Slide from edge for notifications
  - **Drawer** - Full slide for side panels
  - **Fade** - Simple opacity transitions
  - **Backdrop** - Overlay fade animations
  - **Accordion** - Expand/collapse for sections

  ## Accessibility

  All animations respect the user's `prefers-reduced-motion` preference when
  combined with the provided CSS (see `assets/css/mithril_ui/animations.css`).
  """

  @doc """
  Modal enter animation - fade + scale.

  ## Example

      <div
        id="my-modal"
        phx-mounted={JS.show(transition: modal_enter())}
      >
        Modal content
      </div>
  """
  @spec modal_enter() :: {String.t(), String.t(), String.t()}
  def modal_enter do
    {"ease-out duration-200", "opacity-0 scale-95", "opacity-100 scale-100"}
  end

  @doc """
  Modal leave animation - fade + scale.

  ## Example

      JS.hide(transition: modal_leave())
  """
  @spec modal_leave() :: {String.t(), String.t(), String.t()}
  def modal_leave do
    {"ease-in duration-150", "opacity-100 scale-100", "opacity-0 scale-95"}
  end

  @doc """
  Dropdown enter animation - fade + slide down.
  """
  @spec dropdown_enter() :: {String.t(), String.t(), String.t()}
  def dropdown_enter do
    {"ease-out duration-200", "opacity-0 -translate-y-1", "opacity-100 translate-y-0"}
  end

  @doc """
  Dropdown leave animation.
  """
  @spec dropdown_leave() :: {String.t(), String.t(), String.t()}
  def dropdown_leave do
    {"ease-in duration-150", "opacity-100 translate-y-0", "opacity-0 -translate-y-1"}
  end

  @doc """
  Toast enter animation - slide in from right.
  """
  @spec toast_enter() :: {String.t(), String.t(), String.t()}
  def toast_enter do
    {"ease-out duration-300", "opacity-0 translate-x-full", "opacity-100 translate-x-0"}
  end

  @doc """
  Toast leave animation.
  """
  @spec toast_leave() :: {String.t(), String.t(), String.t()}
  def toast_leave do
    {"ease-in duration-200", "opacity-100 translate-x-0", "opacity-0 translate-x-full"}
  end

  @doc """
  Drawer enter animation - slide from specified side.

  ## Parameters

  - `side` - `:left` or `:right`

  ## Example

      JS.show(transition: drawer_enter(:left))
  """
  @spec drawer_enter(:left | :right) :: {String.t(), String.t(), String.t()}
  def drawer_enter(:left) do
    {"ease-out duration-300", "-translate-x-full", "translate-x-0"}
  end

  def drawer_enter(:right) do
    {"ease-out duration-300", "translate-x-full", "translate-x-0"}
  end

  @doc """
  Drawer leave animation - slide to specified side.

  ## Parameters

  - `side` - `:left` or `:right`
  """
  @spec drawer_leave(:left | :right) :: {String.t(), String.t(), String.t()}
  def drawer_leave(:left) do
    {"ease-in duration-200", "translate-x-0", "-translate-x-full"}
  end

  def drawer_leave(:right) do
    {"ease-in duration-200", "translate-x-0", "translate-x-full"}
  end

  @doc """
  Simple fade in animation.
  """
  @spec fade_in() :: {String.t(), String.t(), String.t()}
  def fade_in do
    {"ease-out duration-200", "opacity-0", "opacity-100"}
  end

  @doc """
  Simple fade out animation.
  """
  @spec fade_out() :: {String.t(), String.t(), String.t()}
  def fade_out do
    {"ease-in duration-150", "opacity-100", "opacity-0"}
  end

  @doc """
  Backdrop fade in animation.
  """
  @spec backdrop_enter() :: {String.t(), String.t(), String.t()}
  def backdrop_enter do
    {"ease-out duration-300", "opacity-0", "opacity-100"}
  end

  @doc """
  Backdrop fade out animation.
  """
  @spec backdrop_leave() :: {String.t(), String.t(), String.t()}
  def backdrop_leave do
    {"ease-in duration-200", "opacity-100", "opacity-0"}
  end

  @doc """
  Accordion expand animation.
  """
  @spec accordion_expand() :: {String.t(), String.t(), String.t()}
  def accordion_expand do
    {"ease-out duration-200", "opacity-0 max-h-0", "opacity-100 max-h-screen"}
  end

  @doc """
  Accordion collapse animation.
  """
  @spec accordion_collapse() :: {String.t(), String.t(), String.t()}
  def accordion_collapse do
    {"ease-in duration-150", "opacity-100 max-h-screen", "opacity-0 max-h-0"}
  end

  @doc """
  Tooltip enter animation - fade + slight scale.
  """
  @spec tooltip_enter() :: {String.t(), String.t(), String.t()}
  def tooltip_enter do
    {"ease-out duration-150", "opacity-0 scale-95", "opacity-100 scale-100"}
  end

  @doc """
  Tooltip leave animation.
  """
  @spec tooltip_leave() :: {String.t(), String.t(), String.t()}
  def tooltip_leave do
    {"ease-in duration-100", "opacity-100 scale-100", "opacity-0 scale-95"}
  end

  @doc """
  Alert enter animation - slide down + fade.
  """
  @spec alert_enter() :: {String.t(), String.t(), String.t()}
  def alert_enter do
    {"ease-out duration-300", "opacity-0 -translate-y-2", "opacity-100 translate-y-0"}
  end

  @doc """
  Alert leave animation.
  """
  @spec alert_leave() :: {String.t(), String.t(), String.t()}
  def alert_leave do
    {"ease-in duration-200", "opacity-100 translate-y-0", "opacity-0 -translate-y-2"}
  end
end
