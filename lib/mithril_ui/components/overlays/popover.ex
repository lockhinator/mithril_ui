defmodule MithrilUI.Components.Popover do
  @moduledoc """
  Popover component for displaying rich contextual content.

  Popovers are similar to tooltips but can contain more complex content
  including titles, descriptions, actions, and custom HTML.

  ## Examples

  Basic popover with title and content:

      <.popover id="user-info">
        <:trigger>
          <button class="btn">Show Info</button>
        </:trigger>
        <:title>User Information</:title>
        <:content>
          <p>This is detailed information about the user.</p>
        </:content>
      </.popover>

  Popover with different positions:

      <.popover id="pop-top" position={:top}>...</.popover>
      <.popover id="pop-right" position={:right}>...</.popover>

  Click-triggered popover:

      <.popover id="click-pop" trigger={:click}>...</.popover>

  ## DaisyUI Classes

  - `dropdown` - Container for click-triggered popovers
  - `dropdown-content` - Content container
  - Positioned with `dropdown-top`, `dropdown-bottom`, etc.
  """

  use Phoenix.Component
  alias Phoenix.LiveView.JS

  @doc """
  Renders a hover-triggered popover.

  For hover popovers, we use CSS-based visibility that shows on hover.

  ## Attributes

    * `:id` - Unique identifier for the popover.
    * `:position` - Position relative to trigger. Defaults to `:bottom`.
    * `:class` - Additional CSS classes for the popover content.
    * `:content_class` - Additional CSS classes for the inner content.

  ## Slots

    * `:trigger` - Required. The element that triggers the popover.
    * `:title` - Optional title/header for the popover.
    * `:content` - Required. The main popover content.
    * `:footer` - Optional footer with actions.

  ## Examples

      <.popover id="help-popover" position={:right}>
        <:trigger>
          <button class="btn btn-circle btn-ghost btn-sm">?</button>
        </:trigger>
        <:title>Need Help?</:title>
        <:content>
          <p>Click here to learn more about this feature.</p>
        </:content>
        <:footer>
          <a href="/help" class="link link-primary">View Documentation</a>
        </:footer>
      </.popover>
  """
  @spec popover(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, default: nil, doc: "Unique identifier"

  attr :position, :atom,
    default: :bottom,
    values: [:top, :bottom, :left, :right],
    doc: "Position relative to trigger"

  attr :class, :any, default: nil, doc: "Additional CSS classes for popover"
  attr :content_class, :string, default: nil, doc: "Additional CSS classes for content area"

  slot :trigger, required: true, doc: "Trigger element"
  slot :title, doc: "Popover title/header"
  slot :content, required: true, doc: "Main popover content"
  slot :footer, doc: "Optional footer"

  def popover(assigns) do
    ~H"""
    <div class={["group relative inline-block", @class]}>
      <div class="cursor-pointer">
        {render_slot(@trigger)}
      </div>

      <div
        id={@id}
        role="tooltip"
        class={[
          "absolute z-50 invisible opacity-0 group-hover:visible group-hover:opacity-100",
          "transition-opacity duration-200",
          "w-64 bg-base-100 border border-base-300 rounded-box shadow-xl",
          position_classes(@position)
        ]}
      >
        <div :if={@title != []} class="px-3 py-2 bg-base-200 border-b border-base-300 rounded-t-box">
          <h3 class="font-semibold text-base-content">
            {render_slot(@title)}
          </h3>
        </div>

        <div class={["px-3 py-2 text-sm text-base-content/80", @content_class]}>
          {render_slot(@content)}
        </div>

        <div
          :if={@footer != []}
          class="px-3 py-2 bg-base-200 border-t border-base-300 rounded-b-box"
        >
          {render_slot(@footer)}
        </div>

        <div class={["absolute w-3 h-3 bg-base-100 border rotate-45", arrow_classes(@position)]} />
      </div>
    </div>
    """
  end

  @doc """
  Renders a click-triggered popover using DaisyUI dropdown.

  This variant uses JavaScript to toggle visibility on click.

  ## Attributes

    * `:id` - Required. Unique identifier for the popover.
    * `:position` - Position relative to trigger. Defaults to `:bottom`.
    * `:align` - Horizontal alignment. Defaults to `:start`.
    * `:class` - Additional CSS classes.

  ## Slots

    * `:trigger` - Required. The element that triggers the popover.
    * `:title` - Optional title/header.
    * `:content` - Required. Main content.
    * `:footer` - Optional footer.

  ## Examples

      <.popover_click id="actions-menu" position={:bottom} align={:end}>
        <:trigger>
          <button class="btn btn-ghost btn-sm">
            <.icon name="ellipsis-vertical" class="w-5 h-5" />
          </button>
        </:trigger>
        <:content>
          <ul class="menu menu-sm">
            <li><a>Edit</a></li>
            <li><a>Delete</a></li>
          </ul>
        </:content>
      </.popover_click>
  """
  @spec popover_click(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, required: true, doc: "Unique identifier"

  attr :position, :atom,
    default: :bottom,
    values: [:top, :bottom, :left, :right],
    doc: "Position relative to trigger"

  attr :align, :atom,
    default: :start,
    values: [:start, :center, :end],
    doc: "Horizontal alignment"

  attr :class, :any, default: nil, doc: "Additional CSS classes"
  attr :content_class, :string, default: nil, doc: "Additional CSS classes for content"

  slot :trigger, required: true, doc: "Trigger element"
  slot :title, doc: "Popover title"
  slot :content, required: true, doc: "Main content"
  slot :footer, doc: "Optional footer"

  def popover_click(assigns) do
    ~H"""
    <div class={["dropdown", dropdown_position_class(@position), dropdown_align_class(@align), @class]}>
      <div tabindex="0" role="button" class="cursor-pointer">
        {render_slot(@trigger)}
      </div>
      <div
        id={@id}
        tabindex="0"
        class={[
          "dropdown-content z-50 w-64 bg-base-100 border border-base-300 rounded-box shadow-xl",
          @content_class
        ]}
      >
        <div :if={@title != []} class="px-3 py-2 bg-base-200 border-b border-base-300 rounded-t-box">
          <h3 class="font-semibold text-base-content">
            {render_slot(@title)}
          </h3>
        </div>

        <div class="px-3 py-2 text-sm text-base-content/80">
          {render_slot(@content)}
        </div>

        <div
          :if={@footer != []}
          class="px-3 py-2 bg-base-200 border-t border-base-300 rounded-b-box"
        >
          {render_slot(@footer)}
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Renders a popover controlled by LiveView.JS for programmatic control.

  This variant allows showing/hiding via `show_popover/1` and `hide_popover/1`.

  ## Attributes

    * `:id` - Required. Unique identifier.
    * `:position` - Position relative to trigger.
    * `:show` - Whether popover is initially visible.
    * `:on_cancel` - JS command to run when popover is dismissed.

  ## Examples

      <.popover_controlled id="confirm-pop" show={@show_popover}>
        <:trigger>
          <button phx-click={show_popover("confirm-pop")}>Show</button>
        </:trigger>
        <:content>
          <p>Are you sure?</p>
          <button phx-click={hide_popover("confirm-pop")}>Yes</button>
        </:content>
      </.popover_controlled>
  """
  @spec popover_controlled(map()) :: Phoenix.LiveView.Rendered.t()

  attr :id, :string, required: true, doc: "Unique identifier"

  attr :position, :atom,
    default: :bottom,
    values: [:top, :bottom, :left, :right],
    doc: "Position relative to trigger"

  attr :show, :boolean, default: false, doc: "Initial visibility"
  attr :on_cancel, JS, default: %JS{}, doc: "JS command on dismiss"
  attr :class, :any, default: nil, doc: "Additional CSS classes"

  slot :trigger, required: true, doc: "Trigger element"
  slot :title, doc: "Popover title"
  slot :content, required: true, doc: "Main content"
  slot :footer, doc: "Optional footer"

  def popover_controlled(assigns) do
    ~H"""
    <div class={["relative inline-block", @class]}>
      <div>
        {render_slot(@trigger)}
      </div>

      <div
        id={@id}
        phx-mounted={@show && show_popover(@id)}
        phx-click-away={hide_popover(@on_cancel, @id)}
        class={[
          "absolute z-50 hidden",
          "w-64 bg-base-100 border border-base-300 rounded-box shadow-xl",
          position_classes(@position)
        ]}
      >
        <div :if={@title != []} class="px-3 py-2 bg-base-200 border-b border-base-300 rounded-t-box">
          <h3 class="font-semibold text-base-content">
            {render_slot(@title)}
          </h3>
        </div>

        <div class="px-3 py-2 text-sm text-base-content/80">
          {render_slot(@content)}
        </div>

        <div
          :if={@footer != []}
          class="px-3 py-2 bg-base-200 border-t border-base-300 rounded-b-box"
        >
          {render_slot(@footer)}
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Shows a controlled popover.

  ## Examples

      <button phx-click={MithrilUI.Components.Popover.show_popover("my-popover")}>
        Show
      </button>
  """
  @spec show_popover(String.t()) :: Phoenix.LiveView.JS.t()
  def show_popover(id) do
    JS.show(
      to: "##{id}",
      transition: {"ease-out duration-200", "opacity-0 scale-95", "opacity-100 scale-100"}
    )
  end

  @doc """
  Hides a controlled popover.

  ## Examples

      <button phx-click={MithrilUI.Components.Popover.hide_popover("my-popover")}>
        Hide
      </button>
  """
  @spec hide_popover(String.t()) :: Phoenix.LiveView.JS.t()
  @spec hide_popover(Phoenix.LiveView.JS.t(), String.t()) :: Phoenix.LiveView.JS.t()
  def hide_popover(id) when is_binary(id) do
    JS.hide(
      to: "##{id}",
      transition: {"ease-in duration-150", "opacity-100 scale-100", "opacity-0 scale-95"}
    )
  end

  def hide_popover(%JS{} = js, id) do
    JS.hide(js,
      to: "##{id}",
      transition: {"ease-in duration-150", "opacity-100 scale-100", "opacity-0 scale-95"}
    )
  end

  # Position classes for hover popover (absolute positioning)
  defp position_classes(:top) do
    "bottom-full left-1/2 -translate-x-1/2 mb-2"
  end

  defp position_classes(:bottom) do
    "top-full left-1/2 -translate-x-1/2 mt-2"
  end

  defp position_classes(:left) do
    "right-full top-1/2 -translate-y-1/2 mr-2"
  end

  defp position_classes(:right) do
    "left-full top-1/2 -translate-y-1/2 ml-2"
  end

  # Arrow position classes
  defp arrow_classes(:top) do
    "bottom-0 left-1/2 -translate-x-1/2 translate-y-1/2 border-b border-r border-base-300"
  end

  defp arrow_classes(:bottom) do
    "top-0 left-1/2 -translate-x-1/2 -translate-y-1/2 border-t border-l border-base-300"
  end

  defp arrow_classes(:left) do
    "right-0 top-1/2 -translate-y-1/2 translate-x-1/2 border-t border-r border-base-300"
  end

  defp arrow_classes(:right) do
    "left-0 top-1/2 -translate-y-1/2 -translate-x-1/2 border-b border-l border-base-300"
  end

  # Dropdown position classes
  defp dropdown_position_class(:top), do: "dropdown-top"
  defp dropdown_position_class(:bottom), do: nil
  defp dropdown_position_class(:left), do: "dropdown-left"
  defp dropdown_position_class(:right), do: "dropdown-right"

  # Dropdown alignment classes
  defp dropdown_align_class(:start), do: nil
  defp dropdown_align_class(:center), do: nil
  defp dropdown_align_class(:end), do: "dropdown-end"
end
