defmodule MithrilUI.Components.Alert do
  @moduledoc """
  Alert component for displaying important messages to users.

  Supports semantic variants for different message types and optional
  dismiss functionality with LiveView.JS animations.

  ## Examples

  Basic alert:

      <.alert variant="info">This is an informational message.</.alert>

  Dismissible alert:

      <.alert variant="warning" dismissible id="my-alert">
        This can be closed by the user.
      </.alert>

  Alert with title and icon:

      <.alert variant="success" title="Success!">
        Your changes have been saved.
      </.alert>

  ## Icon Override

  Each variant has a built-in default icon. To use a custom icon (e.g. a Heroicon
  from the consuming application), pass a function component to the `:icon` attribute.
  Do NOT place icon components inside the alert body — use the `:icon` attribute instead.

      <.alert variant="error" icon={&Heroicons.exclamation_triangle/1}>
        Something went wrong.
      </.alert>

  To hide the icon entirely:

      <.alert variant="info" icon={false}>No icon here.</.alert>

  ## DaisyUI Classes

  - `alert` - Base alert styling
  - `alert-info` - Informational style (blue)
  - `alert-success` - Success style (green)
  - `alert-warning` - Warning style (yellow)
  - `alert-error` - Error style (red)
  """

  use Phoenix.Component
  alias Phoenix.LiveView.JS
  import MithrilUI.Animations

  @variants ~w(info success warning error)

  @doc """
  Renders an alert message with optional title and dismiss button.

  ## Attributes

    * `:id` - DOM id (required if dismissible).
    * `:variant` - The alert type: info, success, warning, error.
    * `:title` - Optional title displayed prominently.
    * `:dismissible` - Whether to show a dismiss button. Defaults to false.
    * `:icon` - Controls the alert icon. Accepts:
      * `true` (default) — shows the built-in icon for the variant.
      * `false` — hides the icon.
      * A function component (e.g. `&Heroicons.exclamation_triangle/1`) — renders
        that component as the icon. The component receives a `class` assign.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:inner_block` - The alert message content (required).
    * `:actions` - Optional action buttons/links.

  ## Icon Override

  Icons are built-in — do NOT wrap content with icon components or pass icons
  inside the inner_block. To customize the icon, pass a function component
  to the `:icon` attribute:

      <.alert variant="error" icon={&Heroicons.exclamation_triangle/1}>
        Something went wrong.
      </.alert>

  ## Examples

      <.alert variant="error" title="Error" dismissible id="error-alert">
        Something went wrong. Please try again.
        <:actions>
          <button class="btn btn-sm">Retry</button>
        </:actions>
      </.alert>
  """
  @spec alert(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, default: nil
  attr :variant, :string, default: "info", values: @variants
  attr :title, :string, default: nil
  attr :dismissible, :boolean, default: false
  attr :icon, :any, default: true
  attr :class, :any, default: nil

  slot :inner_block, required: true
  slot :actions

  def alert(assigns) do
    ~H"""
    <div
      id={@id}
      role="alert"
      class={alert_classes(@variant, @class)}
    >
      <.alert_icon :if={@icon != false} icon={@icon} variant={@variant} />
      <div class="flex-1">
        <h3 :if={@title} class="font-bold">{@title}</h3>
        <div class={@title && "text-sm"}>
          {render_slot(@inner_block)}
        </div>
      </div>
      <div :if={@actions != []} class="flex gap-2">
        {render_slot(@actions)}
      </div>
      <button
        :if={@dismissible}
        type="button"
        class="btn btn-sm btn-ghost btn-circle"
        aria-label="Dismiss"
        phx-click={hide_alert(@id)}
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
    </div>
    """
  end

  # When icon is true, render the built-in default SVG for the variant.
  # When icon is a function component (e.g. &Heroicons.exclamation_triangle/1),
  # call it and pass the standard icon classes so it matches the alert layout.
  defp alert_icon(%{icon: true} = assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      class="h-6 w-6 shrink-0 stroke-current"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d={icon_path(@variant)}
      />
    </svg>
    """
  end

  defp alert_icon(%{icon: icon} = assigns) when is_function(icon) do
    assigns = assign(assigns, :icon_assigns, %{class: "h-6 w-6 shrink-0", __changed__: %{}})

    ~H"""
    {@icon.(@icon_assigns)}
    """
  end

  defp icon_path("info"), do: "M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
  defp icon_path("success"), do: "M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"

  defp icon_path("warning"),
    do:
      "M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"

  defp icon_path("error"),
    do: "M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"

  @doc """
  Shows an alert with animation.
  """
  @spec show_alert(String.t()) :: Phoenix.LiveView.JS.t()
  def show_alert(id) do
    JS.show(to: "##{id}", transition: alert_enter())
  end

  @doc """
  Hides an alert with animation.
  """
  @spec hide_alert(String.t()) :: Phoenix.LiveView.JS.t()
  def hide_alert(id) do
    JS.hide(to: "##{id}", transition: alert_leave())
  end

  defp alert_classes(variant, extra_class) do
    [
      "alert",
      "alert-#{variant}",
      extra_class
    ]
  end
end
