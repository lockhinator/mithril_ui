defmodule MithrilUI.Components.Modal do
  @moduledoc """
  Modal dialog component with backdrop and LiveView.JS animations.

  Modals are used for focused interactions that require user attention
  or input before continuing.

  ## Examples

  Basic modal:

      <.modal id="confirm-modal">
        <:title>Confirm Action</:title>
        Are you sure you want to proceed?
        <:actions>
          <button class="btn" phx-click={hide_modal("confirm-modal")}>Cancel</button>
          <button class="btn btn-primary" phx-click="confirm">Confirm</button>
        </:actions>
      </.modal>

  Open modal with button:

      <button phx-click={show_modal("my-modal")}>Open Modal</button>

  ## DaisyUI Classes

  - `modal` - Modal container
  - `modal-box` - Modal content box
  - `modal-backdrop` - Background overlay
  - `modal-open` - Forces modal open
  """

  use Phoenix.Component
  alias Phoenix.LiveView.JS
  import MithrilUI.Animations

  @doc """
  Renders a modal dialog.

  ## Attributes

    * `:id` - Required. Unique identifier for the modal.
    * `:show` - Whether modal is initially visible. Defaults to false.
    * `:on_cancel` - JS command to run when modal is cancelled.
    * `:class` - Additional CSS classes for modal box.

  ## Slots

    * `:title` - Modal title/header.
    * `:inner_block` - Modal body content (required).
    * `:actions` - Footer action buttons.

  ## Examples

      <.modal id="edit-modal" on_cancel={JS.navigate("/")}>
        <:title>Edit Profile</:title>
        <form phx-submit="save">
          <!-- form fields -->
        </form>
        <:actions>
          <button class="btn btn-primary" type="submit">Save</button>
        </:actions>
      </.modal>
  """
  @spec modal(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, required: true
  attr :show, :boolean, default: false
  attr :on_cancel, JS, default: %JS{}
  attr :class, :string, default: nil

  slot :title
  slot :inner_block, required: true
  slot :actions

  def modal(assigns) do
    ~H"""
    <div
      id={@id}
      phx-mounted={@show && show_modal(@id)}
      phx-remove={hide_modal(@id)}
      data-cancel={JS.exec(@on_cancel, "phx-remove")}
      class="modal"
    >
      <div
        id={"#{@id}-backdrop"}
        class="modal-backdrop bg-black/50"
        aria-hidden="true"
        phx-click={JS.exec("data-cancel", to: "##{@id}")}
      />
      <div
        id={"#{@id}-container"}
        class={["modal-box relative", @class]}
        role="dialog"
        aria-modal="true"
        aria-labelledby={@title != [] && "#{@id}-title"}
        phx-window-keydown={JS.exec("data-cancel", to: "##{@id}")}
        phx-key="escape"
        phx-click-away={JS.exec("data-cancel", to: "##{@id}")}
      >
        <button
          type="button"
          class="btn btn-sm btn-circle btn-ghost absolute right-2 top-2"
          aria-label="Close"
          phx-click={JS.exec("data-cancel", to: "##{@id}")}
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

        <h3 :if={@title != []} id={"#{@id}-title"} class="font-bold text-lg pr-8">
          {render_slot(@title)}
        </h3>

        <div class="py-4">
          {render_slot(@inner_block)}
        </div>

        <div :if={@actions != []} class="modal-action">
          {render_slot(@actions)}
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Shows a modal with animations.

  ## Examples

      <button phx-click={MithrilUI.Components.Modal.show_modal("my-modal")}>
        Open
      </button>
  """
  @spec show_modal(String.t()) :: Phoenix.LiveView.JS.t()
  def show_modal(id) do
    JS.add_class("modal-open", to: "##{id}")
    |> JS.show(to: "##{id}-backdrop", transition: backdrop_enter())
    |> JS.show(to: "##{id}-container", transition: modal_enter())
    |> JS.focus_first(to: "##{id}-container")
  end

  @doc """
  Hides a modal with animations.

  ## Examples

      <button phx-click={MithrilUI.Components.Modal.hide_modal("my-modal")}>
        Close
      </button>
  """
  @spec hide_modal(String.t()) :: Phoenix.LiveView.JS.t()
  def hide_modal(id) do
    JS.hide(to: "##{id}-backdrop", transition: backdrop_leave())
    |> JS.hide(to: "##{id}-container", transition: modal_leave())
    |> JS.remove_class("modal-open", to: "##{id}")
    |> JS.pop_focus()
  end
end
