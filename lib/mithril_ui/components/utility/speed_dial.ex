defmodule MithrilUI.Components.SpeedDial do
  @moduledoc """
  Speed dial component for floating action buttons with expandable menus.

  Displays a primary action button that reveals additional action buttons
  on hover or click. Supports various positions, orientations, and
  tooltip labels.
  """
  use Phoenix.Component

  @positions ["bottom-right", "bottom-left", "top-right", "top-left"]
  @orientations ["vertical", "horizontal"]

  @doc """
  Renders a speed dial with action buttons.

  ## Examples

      <.speed_dial id="actions">
        <:action icon="share" label="Share" />
        <:action icon="print" label="Print" />
        <:action icon="download" label="Download" />
      </.speed_dial>
  """
  attr :id, :string, required: true
  attr :position, :string, default: "bottom-right", values: @positions
  attr :orientation, :string, default: "vertical", values: @orientations
  attr :trigger, :string, default: "hover", values: ["hover", "click"]
  attr :icon, :string, default: "plus", values: ["plus", "menu", "dots"]
  attr :color, :string, default: "primary"
  attr :class, :any, default: nil
  attr :rest, :global

  slot :action, required: true do
    attr :icon, :string
    attr :label, :string
    attr :href, :string
    attr :click, :string
    attr :color, :string
    attr :class, :any
  end

  def speed_dial(assigns) do
    ~H"""
    <div
      id={@id}
      class={[
        "fixed group z-50",
        position_classes(@position),
        @class
      ]}
      data-dial-init
      {@rest}
    >
      <div
        id={"#{@id}-menu"}
        class={[
          "flex items-center mb-4 space-y-2",
          orientation_classes(@orientation),
          "invisible opacity-0 group-hover:visible group-hover:opacity-100 transition-all duration-200"
        ]}
      >
        <.speed_dial_action :for={action <- @action} {action} orientation={@orientation} />
      </div>
      <button
        type="button"
        class={[
          "btn btn-circle btn-lg shadow-lg",
          "btn-#{@color}"
        ]}
        data-dial-toggle={"#{@id}-menu"}
        data-dial-trigger={@trigger}
        aria-controls={"#{@id}-menu"}
        aria-expanded="false"
      >
        <.speed_dial_icon icon={@icon} />
        <span class="sr-only">Open actions menu</span>
      </button>
    </div>
    """
  end

  @doc """
  Renders a simple speed dial with slots for custom content.

  ## Examples

      <.speed_dial_simple id="fab" position="bottom-right">
        <:trigger>
          <svg class="w-6 h-6">...</svg>
        </:trigger>
        <:menu>
          <button class="btn btn-circle btn-sm">A</button>
          <button class="btn btn-circle btn-sm">B</button>
        </:menu>
      </.speed_dial_simple>
  """
  attr :id, :string, required: true
  attr :position, :string, default: "bottom-right", values: @positions
  attr :class, :any, default: nil
  attr :rest, :global

  slot :trigger, required: true
  slot :menu, required: true

  def speed_dial_simple(assigns) do
    ~H"""
    <div
      id={@id}
      class={[
        "fixed group z-50",
        position_classes(@position),
        @class
      ]}
      {@rest}
    >
      <div class="flex flex-col items-center mb-4 space-y-2 invisible opacity-0 group-hover:visible group-hover:opacity-100 transition-all duration-200">
        {render_slot(@menu)}
      </div>
      <button type="button" class="btn btn-primary btn-circle btn-lg shadow-lg">
        {render_slot(@trigger)}
      </button>
    </div>
    """
  end

  @doc """
  Renders a speed dial with labeled actions (text alongside icons).

  ## Examples

      <.speed_dial_labeled id="labeled-dial">
        <:action icon="share" label="Share" />
        <:action icon="edit" label="Edit" />
      </.speed_dial_labeled>
  """
  attr :id, :string, required: true
  attr :position, :string, default: "bottom-right", values: @positions
  attr :color, :string, default: "primary"
  attr :class, :any, default: nil
  attr :rest, :global

  slot :action, required: true do
    attr :icon, :string
    attr :label, :string, required: true
    attr :href, :string
    attr :click, :string
    attr :color, :string
  end

  def speed_dial_labeled(assigns) do
    ~H"""
    <div
      id={@id}
      class={[
        "fixed group z-50",
        position_classes(@position),
        @class
      ]}
      {@rest}
    >
      <div class="flex flex-col items-end mb-4 space-y-3 invisible opacity-0 group-hover:visible group-hover:opacity-100 transition-all duration-200">
        <div :for={action <- @action} class="flex items-center gap-2">
          <span class="badge badge-lg shadow">{action[:label]}</span>
          <.action_button {action} />
        </div>
      </div>
      <button type="button" class={["btn btn-circle btn-lg shadow-lg", "btn-#{@color}"]}>
        <svg
          class="w-6 h-6 transition-transform group-hover:rotate-45"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
        </svg>
        <span class="sr-only">Open actions menu</span>
      </button>
    </div>
    """
  end

  @doc """
  Renders a horizontal speed dial variant.

  ## Examples

      <.speed_dial_horizontal id="horizontal">
        <:action icon="share" label="Share" />
        <:action icon="print" label="Print" />
      </.speed_dial_horizontal>
  """
  attr :id, :string, required: true
  attr :position, :string, default: "bottom-right", values: @positions
  attr :color, :string, default: "primary"
  attr :class, :any, default: nil
  attr :rest, :global

  slot :action, required: true do
    attr :icon, :string
    attr :label, :string
    attr :href, :string
    attr :click, :string
    attr :color, :string
  end

  def speed_dial_horizontal(assigns) do
    ~H"""
    <div
      id={@id}
      class={[
        "fixed group z-50",
        position_classes(@position),
        @class
      ]}
      {@rest}
    >
      <div class="flex items-center">
        <div class="flex items-center mr-4 space-x-2 invisible opacity-0 group-hover:visible group-hover:opacity-100 transition-all duration-200">
          <.speed_dial_action :for={action <- @action} {action} orientation="horizontal" />
        </div>
        <button type="button" class={["btn btn-circle btn-lg shadow-lg", "btn-#{@color}"]}>
          <svg
            class="w-6 h-6 transition-transform group-hover:rotate-45"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M12 4v16m8-8H4"
            />
          </svg>
          <span class="sr-only">Open actions menu</span>
        </button>
      </div>
    </div>
    """
  end

  defp speed_dial_action(assigns) do
    assigns =
      assigns
      |> assign_new(:color, fn -> "neutral" end)
      |> assign_new(:orientation, fn -> "vertical" end)

    ~H"""
    <div class={["relative", @orientation == "vertical" && "tooltip tooltip-left"]}>
      <.action_button {assigns} />
      <span :if={@label && @orientation == "vertical"} class="sr-only">{@label}</span>
    </div>
    """
  end

  defp action_button(assigns) do
    assigns =
      assigns
      |> assign_new(:href, fn -> nil end)
      |> assign_new(:click, fn -> nil end)
      |> assign_new(:color, fn -> "neutral" end)
      |> assign_new(:class, fn -> nil end)
      |> assign_new(:icon, fn -> nil end)
      |> assign_new(:label, fn -> nil end)

    ~H"""
    <%= if @href do %>
      <a
        href={@href}
        class={[
          "btn btn-circle shadow-lg",
          "btn-#{@color}",
          @class
        ]}
      >
        <.action_icon icon={@icon} />
        <span :if={@label} class="sr-only">{@label}</span>
      </a>
    <% else %>
      <button
        type="button"
        class={[
          "btn btn-circle shadow-lg",
          "btn-#{@color}",
          @class
        ]}
        phx-click={@click}
      >
        <.action_icon icon={@icon} />
        <span :if={@label} class="sr-only">{@label}</span>
      </button>
    <% end %>
    """
  end

  defp speed_dial_icon(assigns) do
    ~H"""
    <svg
      :if={@icon == "plus"}
      class="w-6 h-6 transition-transform group-hover:rotate-45"
      fill="none"
      stroke="currentColor"
      viewBox="0 0 24 24"
    >
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
    </svg>
    <svg
      :if={@icon == "menu"}
      class="w-6 h-6"
      fill="none"
      stroke="currentColor"
      viewBox="0 0 24 24"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M4 6h16M4 12h16M4 18h16"
      />
    </svg>
    <svg
      :if={@icon == "dots"}
      class="w-6 h-6"
      fill="currentColor"
      viewBox="0 0 24 24"
    >
      <path d="M12 8c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0 2c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0 6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z" />
    </svg>
    """
  end

  defp action_icon(assigns) do
    assigns = assign_new(assigns, :icon, fn -> nil end)

    ~H"""
    <svg
      :if={@icon == "share"}
      class="w-5 h-5"
      fill="none"
      stroke="currentColor"
      viewBox="0 0 24 24"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.368 2.684 3 3 0 00-5.368-2.684z"
      />
    </svg>
    <svg
      :if={@icon == "print"}
      class="w-5 h-5"
      fill="none"
      stroke="currentColor"
      viewBox="0 0 24 24"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"
      />
    </svg>
    <svg
      :if={@icon == "download"}
      class="w-5 h-5"
      fill="none"
      stroke="currentColor"
      viewBox="0 0 24 24"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"
      />
    </svg>
    <svg
      :if={@icon == "edit"}
      class="w-5 h-5"
      fill="none"
      stroke="currentColor"
      viewBox="0 0 24 24"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"
      />
    </svg>
    <svg
      :if={@icon == "copy"}
      class="w-5 h-5"
      fill="none"
      stroke="currentColor"
      viewBox="0 0 24 24"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M8 5H6a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2v-1M8 5a2 2 0 002 2h2a2 2 0 002-2M8 5a2 2 0 012-2h2a2 2 0 012 2m0 0h2a2 2 0 012 2v3m2 4H10m0 0l3-3m-3 3l3 3"
      />
    </svg>
    """
  end

  defp position_classes("bottom-right"), do: "end-6 bottom-6"
  defp position_classes("bottom-left"), do: "start-6 bottom-6"
  defp position_classes("top-right"), do: "end-6 top-6"
  defp position_classes("top-left"), do: "start-6 top-6"

  defp orientation_classes("vertical"), do: "flex-col"
  defp orientation_classes("horizontal"), do: "flex-row space-y-0 space-x-2"
end
