defmodule MithrilUI.Components.Toast do
  @moduledoc """
  Toast notification component with auto-dismiss and stacking support.

  Toasts are brief messages that appear temporarily to provide feedback
  about an action or system status.

  ## Examples

  Basic toast:

      <.toast id="saved-toast" variant="success">
        Changes saved successfully!
      </.toast>

  Toast with auto-dismiss:

      <.toast id="info-toast" variant="info" auto_dismiss={3000}>
        Processing your request...
      </.toast>

  Toast container for stacking:

      <.toast_container position="top-end">
        <.toast :for={toast <- @toasts} id={toast.id} variant={toast.variant}>
          <%= toast.message %>
        </.toast>
      </.toast_container>

  ## DaisyUI Classes

  - `toast` - Toast container for positioning
  - `alert` - Individual toast styling
  """

  use Phoenix.Component
  alias Phoenix.LiveView.JS
  import MithrilUI.Animations

  @variants ~w(info success warning error)
  @positions ~w(top-start top-center top-end middle-start middle-center middle-end bottom-start bottom-center bottom-end)

  @doc """
  Renders a toast notification.

  ## Attributes

    * `:id` - Required. Unique identifier for the toast.
    * `:variant` - The toast type: info, success, warning, error.
    * `:auto_dismiss` - Milliseconds before auto-dismiss (0 = no auto-dismiss).
    * `:dismissible` - Whether to show dismiss button. Defaults to true.
    * `:class` - Additional CSS classes.

  ## Examples

      <.toast id="my-toast" variant="success" auto_dismiss={5000}>
        Operation completed!
      </.toast>
  """
  @spec toast(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, required: true
  attr :variant, :string, default: "info", values: @variants

  attr :auto_dismiss, :integer,
    default: 0,
    doc: "Auto-dismiss after N milliseconds (0 = disabled)"

  attr :dismissible, :boolean, default: true
  attr :class, :any, default: nil

  slot :inner_block, required: true

  def toast(assigns) do
    ~H"""
    <div
      id={@id}
      role="alert"
      class={toast_classes(@variant, @class)}
      phx-mounted={@auto_dismiss > 0 && auto_dismiss_js(@id, @auto_dismiss)}
    >
      <.toast_icon variant={@variant} />
      <span class="flex-1">{render_slot(@inner_block)}</span>
      <button
        :if={@dismissible}
        type="button"
        class="btn btn-sm btn-ghost btn-circle"
        aria-label="Dismiss"
        phx-click={hide_toast(@id)}
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-4 w-4"
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

  @doc """
  Renders a container for positioning toasts.

  ## Attributes

    * `:position` - Where to position toasts on screen.
      Supported: #{Enum.join(@positions, ", ")}.
    * `:class` - Additional CSS classes.

  ## Examples

      <.toast_container position="top-end">
        <%= for toast <- @toasts do %>
          <.toast id={toast.id} variant={toast.variant}><%= toast.message %></.toast>
        <% end %>
      </.toast_container>
  """
  @spec toast_container(map()) :: Phoenix.LiveView.Rendered.t()

  attr :position, :string, default: "bottom-end", values: @positions
  attr :class, :any, default: nil

  slot :inner_block, required: true

  def toast_container(assigns) do
    ~H"""
    <div class={container_classes(@position, @class)}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  defp toast_icon(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      class="h-5 w-5 shrink-0 stroke-current"
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

  defp icon_path("info"), do: "M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
  defp icon_path("success"), do: "M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"

  defp icon_path("warning"),
    do:
      "M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"

  defp icon_path("error"),
    do: "M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"

  @doc """
  Shows a toast with animation.
  """
  @spec show_toast(String.t()) :: Phoenix.LiveView.JS.t()
  def show_toast(id) do
    JS.show(to: "##{id}", transition: toast_enter())
  end

  @doc """
  Hides a toast with animation.
  """
  @spec hide_toast(String.t()) :: Phoenix.LiveView.JS.t()
  def hide_toast(id) do
    JS.hide(to: "##{id}", transition: toast_leave())
  end

  defp auto_dismiss_js(id, delay) do
    JS.transition({"", "", ""}, time: delay)
    |> JS.hide(to: "##{id}", transition: toast_leave())
  end

  defp toast_classes(variant, extra_class) do
    [
      "alert",
      "alert-#{variant}",
      "shadow-lg",
      extra_class
    ]
  end

  defp container_classes(position, extra_class) do
    [
      "toast",
      position_class(position),
      extra_class
    ]
  end

  defp position_class("top-start"), do: "toast-top toast-start"
  defp position_class("top-center"), do: "toast-top toast-center"
  defp position_class("top-end"), do: "toast-top toast-end"
  defp position_class("middle-start"), do: "toast-middle toast-start"
  defp position_class("middle-center"), do: "toast-middle toast-center"
  defp position_class("middle-end"), do: "toast-middle toast-end"
  defp position_class("bottom-start"), do: "toast-bottom toast-start"
  defp position_class("bottom-center"), do: "toast-bottom toast-center"
  defp position_class("bottom-end"), do: "toast-bottom toast-end"
end
